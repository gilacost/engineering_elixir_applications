# START: token_import
# in environments/production/main.tf

# END: token_import
module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
  account_id       = var.account_id
}

module "repository_secrets" {
  source = "../../modules/integrations/github/secrets"
  secrets = {
    "PRIVATE_KEY"           = module.swarm.private_key,
    "AWS_ACCESS_KEY_ID"     = var.aws_access_key_id,
    "AWS_SECRET_ACCESS_KEY" = var.aws_secret_access_key,
    "AGE_KEY"               = var.age_key,
    "GH_PAT"                = var.gh_pat
  }
  repository   = "kanban"
  github_owner = "YOUR_GITHUB_USERNAME"
}

module "contributing_workflow" {
  source        = "../../modules/integrations/github/contributing_workflow"
  repository    = "kanban"
  github_owner  = "BeamOps"
  status_checks = ["Compile with mix test, format, dialyzer & unused deps check"]
}

# START: token_import
import {
  to = module.swarm.aws_ssm_parameter.swarm_token
  id = "/docker/swarm_manager_token"
}
# END: token_import

output "swarm_ssh_command" {
  value = module.swarm.ssh_commands
}
