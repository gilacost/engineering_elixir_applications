# in modules/cloud/aws/compute/swarm/outputs.tf

output "ssh_command" {
  value       = <<-EOF
    ssh -i ${var.private_key_path} \
    ec2-user@${aws_instance.my_swarm.public_ip}
  EOF
  description = "The SSH command to connect to the instance."
}
