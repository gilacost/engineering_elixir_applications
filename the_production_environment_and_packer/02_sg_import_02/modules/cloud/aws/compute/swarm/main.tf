# START: dynamic-sg
# in modules/cloud/aws/compute/swarm/main.tf

# END: dynamic-sg
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

# START: dynamic-sg
resource "aws_instance" "my_swarm" {
  # END: dynamic-sg
  ami               = "ami-0ef9e689241f0bb6e"
  availability_zone = "eu-west-1a"
  instance_type     = "t2.micro"
  key_name          = "swarm-key"
  subnet_id         = "subnet-699da921"
  tags = {
    "Name" = "docker-swarm-manager"
  }
  # START: dynamic-sg
  vpc_security_group_ids = [
    aws_security_group.swarm_sg.id
  ]
}
# END: dynamic-sg

resource "aws_security_group" "swarm_sg" {
  description = "launch-wizard-1 created 2024-03-05T16:16:27.800Z"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 4000
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 4000
    },
  ]
  name     = "launch-wizard-1"
  tags     = {}
  tags_all = {}
  vpc_id   = "vpc-073bd07e"
}
