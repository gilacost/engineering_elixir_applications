# in modules/cloud/aws/compute/swarm/main.tf


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

resource "aws_instance" "my_swarm" {
  ami           = "YOUR_AMI_ID"
  instance_type = "t2.micro"

  tags = {
    "Name" = "docker-swarm-manager"
  }
}
