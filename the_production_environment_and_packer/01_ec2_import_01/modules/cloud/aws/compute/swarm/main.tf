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
  # (resource arguments)
}
