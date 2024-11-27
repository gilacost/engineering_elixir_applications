# START: get_sorted_instances
#!/usr/bin/env bash

# START: prepare_swarm_init
# START: swarm_init
# in modules/cloud/aws/compute/swarm/scripts/launch_node.sh

# END: swarm_init
# END: get_sorted_instances
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

# get a meta-data value of an EC2 instance given the API token and
# attribute name
get_instance_meta_data() {
  local API_TOKEN=$1
  local META_DATA_ATTRIBUTE_NAME=$2
  curl -H "X-aws-ec2-metadata-token: $API_TOKEN" \
        "http://169.254.169.254/latest/meta-data/$META_DATA_ATTRIBUTE_NAME"
}

# END: prepare_swarm_init
# START: swarm_init
# initialize the docker swarm
initialize_swarm() {
  docker swarm init
  local MANAGER_TOKEN=$(docker swarm join-token manager -q)
  aws ssm put-parameter --name "/docker/swarm_manager_token" \
                        --value "$MANAGER_TOKEN" \
                        --type "SecureString" --overwrite
}

# END: swarm_init
# START: get_sorted_instances
# get all of the running EC2 instances
get_running_instance_ids() {
  aws ec2 describe-instances \
    --filters "Name=tag:aws:autoscaling:groupName,Values=$ASG_NAME" \
              "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[InstanceId,LaunchTime]" \
    --output text \
    --region "$REGION" | sort -k2 | awk '{print $1}'
}

# constants
REGION="${region}"
ASG_NAME="${asg_name}" 
SORTED_INSTANCE_IDS_STRING=$(get_running_instance_ids)
SORTED_INSTANCE_IDS_ARRAY=($(echo "$SORTED_INSTANCE_IDS_STRING" \
  | tr ' ' '\n' \
  | tr '\n' ' '))
# END: get_sorted_instances
# START: prepare_swarm_init
SWARM_TOKEN=$(get_swarm_token)
AWS_API_TOKEN=$(get_aws_api_token)
CURRENT_INSTANCE_ID=$(get_instance_meta_data $AWS_API_TOKEN "instance-id")
# END: prepare_swarm_init

# START: swarm_init
# if there is no swarm token and the current instance is the first in
# the list
if [ "$SWARM_TOKEN" == "NONE" ] && \
  [[ $CURRENT_INSTANCE_ID == "$${SORTED_INSTANCE_IDS_ARRAY[0]}" ]]; then
  initialize_swarm
else
  break # you'll fill this in in the next section
fi
# END: swarm_init
