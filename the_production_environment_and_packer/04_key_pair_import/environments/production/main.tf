# in environments/production/main.tf

module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
}

import {
  to = module.swarm.aws_key_pair.deployer_key
  id = "swarm-key"
}

output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}
