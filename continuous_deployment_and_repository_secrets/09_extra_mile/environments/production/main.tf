# START: import_repository_secrets_module
# START: import_contributing_workflow_module
# in environments/production/main.tf

# END: import_contributing_workflow_module
module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
}

module "repository_secrets" {
  source = "../../modules/integrations/github/secrets"
  secrets = {
    "PRIVATE_KEY"           = module.swarm.private_key,
    "AWS_ACCESS_KEY_ID"     = var.aws_access_key_id,
    "AWS_SECRET_ACCESS_KEY" = var.aws_secret_access_key,
    "AGE_KEY"               = module.sops.private_key,
    "GH_PAT"                = var.gh_pat
  }
  repository   = "kanban"
  github_owner = "YOUR_GITHUB_USERNAME"
}
# END: import_repository_secrets_module

# START: import_contributing_workflow_module
module "contributing_workflow" {
  source        = "../../modules/integrations/github/contributing_workflow"
  repository    = "kanban"
  github_owner  = "BeamOps"
  status_checks = ["Compile with mix test, format, dialyzer & unused deps check"]
}
# END: import_contributing_workflow_module

output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}

output "age_public_key" {
  value = module.sops.public_key
}

# START: extra_mile_using_sops_age_providers
# in environments/production/main.tf

module "sops" {
  source                = "../../modules/integrations/sops"
  private_key_file_path = "${path.module}/key.txt"
  sops_config_file_path = "../../.sops.yaml"
}
# END: extra_mile_using_sops_age_providers
