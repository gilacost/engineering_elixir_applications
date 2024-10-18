terraform {
  required_providers {
    age = {
      source  = "clementblaise/age"
      version = "0.1.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

variable "private_key_file_path" {
  description = "Path where the Age private (secret) key will be saved."
  type        = string
  default     = "key.txt"
}

variable "sops_config_file_path" {
  description = "Path for the .sops.yaml configuration file."
  type        = string
  default     = ".sops.yaml"
}

resource "age_secret_key" "main" {}

resource "local_sensitive_file" "main" {
  content  = age_secret_key.main.secret_key
  filename = var.private_key_file_path
}

resource "local_file" "config_file" {
  content = templatefile("${path.module}/sops.tpl", {
    age_public_key = age_secret_key.main.public_key
  })
  filename = var.sops_config_file_path
}

output "public_key" {
  value = age_secret_key.main.public_key
}

output "private_key" {
  value = age_secret_key.main.secret_key
}
