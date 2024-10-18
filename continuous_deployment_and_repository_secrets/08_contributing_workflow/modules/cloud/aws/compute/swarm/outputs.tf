# in modules/cloud/aws/compute/swarm/outputs.tf

output "ssh_command" {
  value       = "ssh -i ${path.module}/private_key.pem ec2-user@${aws_instance.my_swarm.public_ip}"
  description = "The SSH command to connect to the instance."
}

output "private_key" {
  value       = local_sensitive_file.private_key.content
  sensitive   = true
  description = "The SSH private key to connect to the instance."
}
