# START:locals_block
# START:repo_with_local_value
# START:provider_with_local_value
# in modules/integrations/github/project_management/main.tf

# END:locals_block
# END:repo_with_local_value
# END:provider_with_local_value
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}

# START:locals_block
locals {
  repository_name = "kanban"
  github_owner    = "YOUR_GITHUB_USERNAME"
}
# END:locals_block

# START:repo_with_local_value
resource "github_repository" "kanban" {
  name = local.repository_name
  # END:repo_with_local_value
  description            = "Taking the BEAM to production pragmatically."
  visibility             = "private"
  has_issues             = true
  auto_init              = true
  gitignore_template     = "Terraform"
  delete_branch_on_merge = true
  # START:repo_with_local_value
}
# END:repo_with_local_value

# START:provider_with_local_value
provider "github" {
  owner = local.github_owner
}
# END:provider_with_local_value
