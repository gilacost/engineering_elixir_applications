# in modules/integrations/github/secrets/main.tf

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
}

resource "github_actions_secret" "main" {
  for_each = var.secrets

  repository      = var.repository
  secret_name     = each.key
  plaintext_value = each.value
}
