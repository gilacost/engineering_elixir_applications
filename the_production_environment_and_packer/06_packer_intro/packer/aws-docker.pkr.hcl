# in packer/aws-docker.pkr.hcl

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "base" {
  ami_regions = ["eu-west-1"]
  source_ami    = "YOUR_AMI_ID"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "amazon-linux-docker_{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.base"]

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y docker",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -a -G docker ec2-user",
      "sudo dnf install -y nmap"
    ]
  }
}
