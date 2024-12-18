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

variable "milestones" {
  type = map(object({
    title       = string
    due_date    = string
    description = string
  }))
  description = "Milestones, consider them the biggest deliverable unit."
}

resource "github_repository_milestone" "epics" {
  for_each    = var.milestones
  owner       = local.github_owner
  repository  = local.repository_name
  title       = each.value.title
  description = replace(each.value.description, "\n", " ")
  due_date    = each.value.due_date
}

variable "labels" {
  type = map(object({
    name  = string
    color = string
  }))
  description = "The labels to tag the issues."
}

resource "github_issue_label" "issues_labels" {
  for_each   = var.labels
  repository = local.repository_name
  name       = each.value.name
  color      = each.value.color
}

provider "github" {
  owner = local.github_owner
}
