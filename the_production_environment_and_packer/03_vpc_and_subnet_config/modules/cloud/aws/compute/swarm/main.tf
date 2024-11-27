# START: dynamic-vpc-and-subnet
# START: vpc-and-subnet-data-sources
# in modules/cloud/aws/compute/swarm/main.tf

# END: dynamic-vpc-and-subnet
# END: vpc-and-subnet-data-sources
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

# START: vpc-and-subnet-data-sources
data "aws_vpc" "main" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

data "aws_subnets" "main_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}
# END: vpc-and-subnet-data-sources

# START: dynamic-vpc-and-subnet
resource "aws_instance" "my_swarm" {
  # END: dynamic-vpc-and-subnet
  ami               = "ami-0ef9e689241f0bb6e"
  availability_zone = "eu-west-1a"
  instance_type     = "t2.micro"
  key_name          = "swarm-key"
  # START: dynamic-vpc-and-subnet
  subnet_id = data.aws_subnets.main_subnets.ids[2]
  # END: dynamic-vpc-and-subnet
  tags = {
    "Name" = "docker-swarm-manager"
  }
  vpc_security_group_ids = [
    aws_security_group.swarm_sg.id
  ]
  # START: dynamic-vpc-and-subnet
}
# END: dynamic-vpc-and-subnet
# START: dynamic-vpc-and-subnet

resource "aws_security_group" "swarm_sg" {
  description = "launch-wizard-1 created 2024-03-05T16:16:27.800Z"
  # END: dynamic-vpc-and-subnet
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
  # START: dynamic-vpc-and-subnet
  vpc_id = data.aws_vpc.main.id
}
# END: dynamic-vpc-and-subnet
