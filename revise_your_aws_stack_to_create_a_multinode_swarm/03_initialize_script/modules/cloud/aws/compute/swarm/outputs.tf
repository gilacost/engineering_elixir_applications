# in modules/cloud/aws/compute/swarm/outputs.tf

output "ssh_commands" {
  value = {
    for idx, instance in aws_instance.swarm_node :
    format("node_%d", idx + 1) =>
    format("ssh -i ./private_key.pem ec2-user@%s", instance.public_ip)
  }
  description = "The SSH commands to connect to the instances."
}

output "private_key" {
  value       = local_sensitive_file.private_key.content
  sensitive   = true
  description = "The SSH private key to connect to the instance."
}
