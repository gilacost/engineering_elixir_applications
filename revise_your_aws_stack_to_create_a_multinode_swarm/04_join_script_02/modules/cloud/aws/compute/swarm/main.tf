# START: swarm_token
# in modules/cloud/aws/compute/swarm/main.tf
# END: swarm_token

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

locals {
  init_script = file("${path.module}/scripts/initialize.sh")
  manager_tag = "docker-swarm-manager"
  join_script = templatefile("${path.module}/scripts/join.sh", {
    manager_tag = local.manager_tag,
    region      = var.region
  })
}

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

# START: swarm_token 
resource "aws_ssm_parameter" "swarm_token" {
  name        = "/docker/swarm_manager_token"
  description = "The swarm manager join token"
  type        = "SecureString"
  value       = "NONE"
  lifecycle {
    ignore_changes = [value]
  }
}
# END: swarm_token

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_sensitive_file" "private_key" {
  filename        = var.private_key_path
  content         = tls_private_key.rsa.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "swarm-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

data "aws_ami" "amazon_linux_docker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-linux-docker*"]
  }

  owners = ["YOUR_AWS_ACCOUNT_ID"]
}

# START: swarm_token 
resource "aws_instance" "swarm_node" {
  # END: swarm_token
  ami           = data.aws_ami.amazon_linux_docker.id
  count         = var.number_of_nodes
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  subnet_id = data.aws_subnets.main_subnets.ids[
    count.index % length(data.aws_subnets.main_subnets.ids)
  ]
  iam_instance_profile = aws_iam_instance_profile.main_profile.name
  user_data            = count.index == 0 ? local.init_script : local.join_script

  tags = {
    Name = local.manager_tag
  }
  vpc_security_group_ids = [
    aws_security_group.swarm_sg.id
  ]

  lifecycle {
    ignore_changes = [tags]
  }
  # START: swarm_token 
  depends_on = [aws_ssm_parameter.swarm_token]
}
# END: swarm_token
