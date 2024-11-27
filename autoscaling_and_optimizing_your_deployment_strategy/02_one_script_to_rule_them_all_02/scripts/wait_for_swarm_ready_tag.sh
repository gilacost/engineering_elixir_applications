
#!/usr/bin/env bash

# in scripts/wait_for_swarm_ready_tag.sh

while true; do
    MANAGER_IP=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$INSTANCE_MANAGER_TAG" \
                  "Name=instance-state-name,Values=running" \
                  "Name=tag:SwarmReady,Values=true" \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --region "$AWS_REGION" --output text)

    if [ -n "$MANAGER_IP" ] && [ "$MANAGER_IP" != "None" ]; then
        break
    fi
    echo "No instances with SwarmReady tag yet. Retrying in 2 seconds..."
    sleep 2
done