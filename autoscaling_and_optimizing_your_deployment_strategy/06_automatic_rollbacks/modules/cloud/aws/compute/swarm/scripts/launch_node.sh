#!/usr/bin/env bash

# in modules/cloud/aws/compute/swarm/scripts/launch_node.sh

# get swarm token from parameter store
get_swarm_token() {
  aws ssm get-parameter \
      --name "/docker/swarm_manager_token" \
      --query "Parameter.Value" \
      --output text \
      --with-decryption 2>/dev/null
}

# get API token to be able to query EC2 instance data
get_aws_api_token() {
  curl -X PUT "http://169.254.169.254/latest/api/token" \
       -H "X-aws-ec2-metadata-token-ttl-seconds: 3600"
}

# initialize the docker swarm
initialize_swarm() {
  docker swarm init
  local MANAGER_TOKEN=$(docker swarm join-token manager -q)
  aws ssm put-parameter --name "/docker/swarm_manager_token" \
                        --value "$MANAGER_TOKEN" \
                        --type "SecureString" --overwrite
}

# get all of the running EC2 instances
get_running_instance_ids() {
  aws ec2 describe-instances \
    --filters "Name=tag:aws:autoscaling:groupName,Values=$ASG_NAME" \
              "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[InstanceId,LaunchTime]" \
    --output text \
    --region "$REGION" | sort -k2 | awk '{print $1}'
}

# get a meta-data value of an EC2 instance given the API token and
# attribute name
get_instance_meta_data() {
  local API_TOKEN=$1
  local META_DATA_ATTRIBUTE_NAME=$2
  curl -H "X-aws-ec2-metadata-token: $API_TOKEN" \
        "http://169.254.169.254/latest/meta-data/$META_DATA_ATTRIBUTE_NAME"
}

# join the current EC2 as a node to the docker swarm given its swarm
# token
join_swarm() {
  local TOKEN=$1
  local MANAGER_IP=$(aws ec2 describe-instances \
      --filters "Name=tag:Name,Values=$MANAGER_TAG" \
                "Name=instance-state-name,Values=running" \
                "Name=tag:$SWARM_READY_TAG,Values=true" \
      --query "Reservations[0].Instances[0].PrivateIpAddress" \
      --region "$REGION" --output text)
  docker swarm join --token "$TOKEN" "$MANAGER_IP:2377"
}

# constants
REGION="${region}"
ASG_NAME="${asg_name}" 
SORTED_INSTANCE_IDS_STRING=$(get_running_instance_ids)
SORTED_INSTANCE_IDS_ARRAY=($(echo "$SORTED_INSTANCE_IDS_STRING" \
  | tr ' ' '\n' \
  | tr '\n' ' '))
SWARM_TOKEN=$(get_swarm_token)
AWS_API_TOKEN=$(get_aws_api_token)
CURRENT_INSTANCE_ID=$(get_instance_meta_data $AWS_API_TOKEN "instance-id")
MANAGER_TAG="${manager_tag}"
SWARM_READY_TAG="SwarmReady"

# if there is no swarm token and the current instance is the first in
# the list
if [ "$SWARM_TOKEN" == "NONE" ] \
  && [[ $CURRENT_INSTANCE_ID == "$${SORTED_INSTANCE_IDS_ARRAY[0]}" ]]; then
  initialize_swarm
else
# get the swarm token until it is not NONE and then join the swarm 
  while [ "$SWARM_TOKEN" == "NONE" ]; do
    SWARM_TOKEN=$(get_swarm_token)
    sleep 2
  done

  join_swarm "$SWARM_TOKEN"

  INSTANCE_COUNT=$(echo "$SORTED_INSTANCE_IDS_STRING" | wc -l)
  docker service update --replicas="$INSTANCE_COUNT" kanban_web
fi

# make sure port 22 of the current instance is open so that SSH is possible
CURRENT_INSTANCE_IP=$(get_instance_meta_data "$AWS_API_TOKEN" "public-ipv4")
while ! nc -z -v -w1 "$CURRENT_INSTANCE_IP" 22; do 
  echo "Waiting for SSH to be available..."
  sleep 2
done

# indicate that this instance is ready to receive docker commands
aws ec2 create-tags \
    --resources "$CURRENT_INSTANCE_ID" \
    --tags "Key=$SWARM_READY_TAG,Value=true" \
    --region "$REGION"
