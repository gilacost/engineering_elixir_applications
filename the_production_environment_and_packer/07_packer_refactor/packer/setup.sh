#!/usr/bin/env bash

# in packer/setup.sh

set -ex

sudo dnf update -y
sudo dnf install -y docker nc
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo dnf install -y nmap
