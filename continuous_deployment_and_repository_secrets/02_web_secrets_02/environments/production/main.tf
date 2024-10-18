# in environments/production/main.tf

module "swarm" {
  source           = "../../modules/cloud/aws/compute/swarm"
  private_key_path = "${path.module}/private_key.pem"
}

output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}
