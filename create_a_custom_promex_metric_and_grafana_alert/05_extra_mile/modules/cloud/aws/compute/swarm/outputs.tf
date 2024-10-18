# in modules/cloud/aws/compute/swarm/outputs.tf

output "ssh_commands" {
  value       = <<-EOT
    aws ec2 describe-instances \
      --query "Reservations[*].Instances[*].{IP:PublicIpAddress}" \
      --filters \
      "Name=tag:aws:autoscaling:groupName,Values=${local.asg_name}" \
      "Name=instance-state-name,Values=running" \
      --region ${var.region} \
      --output text | \
      awk '{print "ssh -i ./private_key.pem ec2-user@"$1}'
  EOT
  description = "AWS CLI command to print the EC2 instance SSH commands."
}

output "private_key" {
  value       = local_sensitive_file.private_key.content
  sensitive   = true
  description = "The SSH private key to connect to the instance."
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = "open http://${aws_lb.main.dns_name}"
}
