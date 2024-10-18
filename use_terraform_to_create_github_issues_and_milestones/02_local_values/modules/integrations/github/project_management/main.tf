# in modules/integrations/github/project_management/main.tf

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}

locals {
  repository_name = "kanban"
  github_owner    = "YOUR_GITHUB_USERNAME"
}

resource "github_repository" "kanban" {
  name                   = local.repository_name
  description            = "Taking the BEAM to production pragmatically."
  visibility             = "private"
  has_issues             = true
  auto_init              = true
  gitignore_template     = "Terraform"
  delete_branch_on_merge = true
}

provider "github" {
  owner = local.github_owner
}
