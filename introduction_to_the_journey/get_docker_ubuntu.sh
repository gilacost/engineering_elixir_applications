#!/bin/bash

echo "Downloading and installing Docker using the get-docker script..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo "Adding the current user to the docker group to run docker without sudo..."
usermod -aG docker "$USER"

newgrp docker

echo "Verifying Docker installation..."
docker --version

echo "Verifying Docker Compose installation..."
docker compose version || docker-compose --version
