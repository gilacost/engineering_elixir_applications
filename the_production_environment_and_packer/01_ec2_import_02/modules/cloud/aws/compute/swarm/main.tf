# START: required_import_values
# in modules/cloud/aws/compute/swarm/main.tf

# END: required_import_values

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

# START: required_import_values
resource "aws_instance" "my_swarm" {
  ami           = "ami-0ef9e689241f0bb6e"
  instance_type = "t2.micro"
}
# END: required_import_values
