# START:milestones_variable
# START:milestone_resource_with_variables
# in modules/integrations/github/project_management/main.tf

# END:milestones_variable
# END:milestone_resource_with_variables
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

# START:milestones_variable
variable "milestones" {
  type = map(object({
    title       = string
    due_date    = string
    description = string
  }))
  description = "Milestones, consider them the biggest deliverable unit."
}
# END:milestones_variable

# START:milestone_resource_with_variables
resource "github_repository_milestone" "epics" {
  for_each    = var.milestones
  owner       = local.github_owner
  repository  = local.repository_name
  title       = each.value.title
  description = replace(each.value.description, "\n", " ")
  due_date    = each.value.due_date
}
# END:milestone_resource_with_variables

provider "github" {
  owner = local.github_owner
}
