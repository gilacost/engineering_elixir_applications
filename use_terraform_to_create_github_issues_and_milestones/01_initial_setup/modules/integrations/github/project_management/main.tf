# START:repo
# in modules/integrations/github/project_management/main.tf

# END:repo
# START:provider
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}

# END:provider
# START:repo
resource "github_repository" "kanban" {
  name                   = "kanban"
  description            = "Taking the BEAM to production pragmatically."
  visibility             = "private"
  has_issues             = true
  auto_init              = true
  gitignore_template     = "Terraform"
  delete_branch_on_merge = true
}
# END:repo

# START:provider
provider "github" {
  owner = "YOUR_GITHUB_USERNAME"
}
# END:provider
