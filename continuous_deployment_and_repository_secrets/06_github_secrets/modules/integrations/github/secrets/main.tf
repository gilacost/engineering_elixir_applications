# START: github_provider_config
# START: github_required_providers
# START: github_actions_secret-resource
# in modules/integrations/github/secrets/main.tf

# END: github_provider_config
# END: github_actions_secret-resource
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.41.0"
    }
  }
}
# END: github_required_providers

# START: github_provider_config
provider "github" {
  owner = var.github_owner
}
# END: github_provider_config

# START: github_actions_secret-resource
resource "github_actions_secret" "main" {
  for_each = var.secrets

  repository      = var.repository
  secret_name     = each.key
  plaintext_value = each.value
}
# END: github_actions_secret-resource
