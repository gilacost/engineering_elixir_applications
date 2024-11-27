# START: private_key_variable
# in modules/cloud/aws/compute/swarm/outputs.tf

# END: private_key_variable
output "ssh_command" {
  value       = "ssh -i ${path.module}/private_key.pem ec2-user@${aws_instance.my_swarm.public_ip}"
  description = "The SSH command to connect to the instance."
}

# START: private_key_variable
output "private_key" {
  value       = local_sensitive_file.private_key.content
  sensitive   = true
  description = "The SSH private key to connect to the instance."
}
# END: private_key_variable
