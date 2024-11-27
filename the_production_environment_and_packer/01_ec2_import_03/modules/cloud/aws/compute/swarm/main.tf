# START: initial_import_values
# in modules/cloud/aws/compute/swarm/main.tf

# END: initial_import_values

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

# START: initial_import_values
resource "aws_instance" "my_swarm" {
  ami           = "YOUR_AMI_ID"
  instance_type = "t2.micro"

  tags = {
    "Name" = "docker-swarm-manager"
  }
}
# END: initial_import_values
