# START: swarm-module
# START: swarm-module-output
# START: key_pair_import
# in environments/production/main.tf

# END: key_pair_import
# END: swarm-module-output
module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
}
# END: swarm-module

# START: key_pair_import
import {
  to = module.swarm.aws_key_pair.deployer_key
  id = "swarm-key"
}
# END: key_pair_import

# START: swarm-module-output
output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}
# END: swarm-module-output
