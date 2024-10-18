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
  ami               = "ami-0ef9e689241f0bb6e"
  availability_zone = "eu-west-1a"
  instance_type     = "t2.micro"
  key_name          = "swarm-key"
  subnet_id         = "subnet-699da921"
  tags = {
    "Name" = "docker-swarm-manager"
  }
  vpc_security_group_ids = [
    "sg-0fdcee06ed70d0116",
  ]
}
