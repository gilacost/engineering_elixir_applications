# START: auto_scaling_group
# START: launch_template
# in modules/cloud/aws/compute/swarm/autoscaling.tf

locals {
  # END: launch_template
  asg_name = "swarm-asg"
  # END: auto_scaling_group
  # START: launch_template
  launch_node_script = templatefile("${path.module}/scripts/initialize.sh", {
    manager_tag = local.manager_tag,
    region      = var.region
  })
  # START: auto_scaling_group
}

# END: auto_scaling_group
resource "aws_launch_template" "swarm_node" {
  image_id               = data.aws_ami.amazon_linux_docker.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer_key.key_name
  name_prefix            = "swarm-node-"
  vpc_security_group_ids = [aws_security_group.swarm_sg.id]
  user_data              = base64encode(local.launch_node_script)

  iam_instance_profile {
    name = aws_iam_instance_profile.main_profile.name
  }
}

# START: auto_scaling_group
resource "aws_autoscaling_group" "main" {
  # END: launch_template
  name = local.asg_name

  vpc_zone_identifier = data.aws_subnets.main_subnets.ids
  max_size            = var.number_of_nodes + 4
  min_size            = var.number_of_nodes
  health_check_type   = "EC2"

  termination_policies = ["NewestInstance"]

  tag {
    key                 = "Name"
    value               = local.manager_tag
    propagate_at_launch = true
  }

  # END: auto_scaling_group
  # START: launch_template
  launch_template {
    id      = aws_launch_template.swarm_node.id
    version = "$Latest"
  }
  # END: launch_template
  # START: auto_scaling_group
  depends_on = [aws_ssm_parameter.swarm_token]
  # START: launch_template
}
# END: auto_scaling_group
# END: launch_template
