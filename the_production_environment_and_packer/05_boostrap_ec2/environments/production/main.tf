# START: swarm-module
# in environments/production/main.tf

module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
}
# END: swarm-module

# START: swarm-module-output
output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}
# END: swarm-module-output
