#!/usr/bin/env bash

# in modules/cloud/aws/compute/swarm/scripts/join.sh

get_aws_api_token() {
  curl -X PUT "http://169.254.169.254/latest/api/token" \
       -H "X-aws-ec2-metadata-token-ttl-seconds: 3600"
}

get_instance_meta_data() {
  local API_TOKEN=$1
  local META_DATA_ATTRIBUTE_NAME=$2
  curl -H "X-aws-ec2-metadata-token: $API_TOKEN" \
        "http://169.254.169.254/latest/meta-data/$META_DATA_ATTRIBUTE_NAME"
}

# get swarm token
while true; do
  TOKEN=$(aws ssm get-parameter \
            --name "/docker/swarm_manager_token" \
            --query "Parameter.Value" --output text \
            --with-decryption)
  echo "Waiting for Swarm Manager token..." 
  sleep 2
done

# get primary node's IP
MANAGER_IP=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=${manager_tag}" \
              "Name=instance-state-name,Values=running" \
              "Name=tag:SwarmReady,Values=true" \
    --query "Reservations[0].Instances[0].PrivateIpAddress" \
    --region "${region}" --output text)

# join swarm
docker swarm join --token "$TOKEN" "$MANAGER_IP:2377"

# ensure port 22 is open
AWS_API_TOKEN=$(get_aws_api_token)
CURRENT_INSTANCE_IP=$(get_instance_meta_data "$AWS_API_TOKEN" "public-ipv4")

while ! nc -z -v -w1 "$CURRENT_INSTANCE_IP" 22; do 
  echo "Waiting for SSH to be available..."
  sleep 2
done

# add "SwarmReady" tag
CURRENT_INSTANCE_ID=$(get_instance_meta_data "$AWS_API_TOKEN" "instance-id")

aws ec2 create-tags \
    --resources "$CURRENT_INSTANCE_ID" \
    --tags "Key=SwarmReady,Value=true" \
    --region "eu-west-2"
