terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}

locals {
  github_owner = "YOUR_GITHUB_USERNAME"
}

resource "github_repository" "kanban" {
  name                   = "kanban"
  description            = "Taking the BEAM to production pragmatically."
  visibility             = "private"
  has_issues             = true
  auto_init              = true
  gitignore_template     = "Terraform"
  delete_branch_on_merge = true
}

resource "github_repository_milestone" "epics" {
  for_each    = var.milestones
  owner       = local.github_owner
  repository  = github_repository.kanban.name
  title       = each.value.title
  description = replace(each.value.description, "\n", " ")
  due_date    = each.value.due_date
}


resource "github_issue_label" "issues_labels" {
  for_each   = var.labels
  repository = github_repository.kanban.name
  name       = each.value.name
  color      = each.value.color
}

resource "github_issue" "tasks" {
  count      = length(var.issues)
  repository = github_repository.kanban.name
  title      = var.issues[count.index].title
  body       = var.issues[count.index].body
  milestone_number = github_repository_milestone.epics[
    var.issues[count.index].milestone
  ].number
  labels = [for l in var.issues[count.index].labels :
    github_issue_label.issues_labels[l].name
  ]
}

provider "github" {
  owner = local.github_owner
}
