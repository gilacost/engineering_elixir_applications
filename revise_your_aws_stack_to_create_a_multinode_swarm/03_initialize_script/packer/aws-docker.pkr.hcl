# in packer/aws-docker.pkr.hcl

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

// START: dynamic-ami-region
// START: source-ami-filter
source "amazon-ebs" "base" {
  // END: dynamic-ami-region
  // END: source-ami-filter
  ami_name      = "amazon-linux-docker_{{timestamp}}"
  instance_type = "t2.micro"

  // START: source-ami-filter
  source_ami_filter {
    filters = {
      name         = "al2023-ami-2023*"
      architecture = "x86_64"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  // END: source-ami-filter
  ssh_username = "ec2-user"
  // START: dynamic-ami-region
  ami_regions  = var.ami_regions
  // START: source-ami-filter
}
// END: source-ami-filter
// END: dynamic-ami-region

// START: shell-build
build {
  // END: shell-build
  sources = ["source.amazon-ebs.base"]

  provisioner "shell" {
    inline = ["sudo dnf update -y cloud-init"]
  }

  // START: shell-build
  provisioner "shell" {
    script = "setup.sh"
    # run script after cloud-init finishes to avoid race conditions
    execute_command = "cloud-init status --wait && sudo -E sh '{{ .Path }}'"
  }
  // END: shell-build
}
