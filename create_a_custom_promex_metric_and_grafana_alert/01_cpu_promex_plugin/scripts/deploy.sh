#!/usr/bin/env bash
# in scripts/deploy.sh

# set exit and logging rule for script
set -ex

# check for required tools (AWS CLI and Docker) and exit if not found
command -v aws >/dev/null 2>&1 || {
  echo "Error: AWS CLI not found. Please install it."; exit 1;
}
command -v docker >/dev/null 2>&1 || {
  echo "Error: Docker not found. Please install it."; exit 1;
}

# check that the necessary env variables have been passed and exit if not
if [ -z "$SOPS_AGE_KEY_FILE" ]; then
  echo "Error: Please set the SOPS_AGE_KEY_FILE environment variable."
  exit 1
fi

if [ -z "$PRIVATE_KEY_PATH" ]; then
  echo "Error: Please set the PRIVATE_KEY_PATH environment variable."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "Error: Please set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY."
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USER" ]; then
  echo "Error: Please set both the GITHUB_TOKEN and GITHUB_USER."
  exit 1
fi

# set default variables
IMAGE=${1:-"ghcr.io/beamops/kanban:latest"}
AWS_REGION="eu-west-1"
INSTANCE_TAG_NAME="docker-swarm-manager"
STACK_NAME="kanban"
COMPOSE_FILE_PATH=${COMPOSE_FILE_PATH:-"compose.yaml"}

# get EC2 IP address
MANAGER_IP=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_TAG_NAME" \
              "Name=instance-state-name,Values=running" \
              "Name=tag:SwarmReady,Values=true" \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --region "$AWS_REGION" --output text)

# exit if no running EC2 found TODO different from None
if [ -z "$MANAGER_IP" ]; then
  echo "Error: No instance found with tag name $INSTANCE_TAG_NAME."
  exit 1
fi

# decrypt secrets and create secret files
CURRENT_DIRECTORY=$(dirname "$0")
"$CURRENT_DIRECTORY/decrypt.sh"

# add SSH key to ssh-agent
eval "$(ssh-agent -s)"
chmod 600 "$PRIVATE_KEY_PATH"
mkdir -p ~/.ssh/
ssh-add "$PRIVATE_KEY_PATH"

# add EC2 IP to list of known hosts
ssh-keyscan -H -v "$MANAGER_IP" >> ~/.ssh/known_hosts

# log in to the GitHub Docker registry if not already logged in
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin

# deploy the application
DOCKER_HOST="ssh://ec2-user@$MANAGER_IP" \
WEB_IMAGE="$IMAGE" \
docker stack deploy -c "$COMPOSE_FILE_PATH" --with-registry-auth \
"$STACK_NAME"

# remove purge stack if it exists
DOCKER_HOST="ssh://ec2-user@$MANAGER_IP" docker stack rm "system_prune"

# deploy purge stack globally
PURGE_FILE_PATH=${PURGE_FILE_PATH:-"tasks/purge.yaml"}
DOCKER_HOST="ssh://ec2-user@$MANAGER_IP" \
docker stack deploy -c "$PURGE_FILE_PATH" "system_prune"

echo "Deployment completed."
