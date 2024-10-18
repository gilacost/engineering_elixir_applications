# in modules/cloud/aws/compute/swarm/autoscaling.tf

locals {
  asg_name = "swarm-asg"
  launch_node_script = templatefile("${path.module}/scripts/launch_node.sh",
    {
      manager_tag = local.manager_tag,
      region      = var.region,
      asg_name    = local.asg_name
  })
}

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
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "main" {
  name = local.asg_name

  vpc_zone_identifier = data.aws_subnets.main_subnets.ids
  max_size            = var.number_of_nodes + 4
  min_size            = var.number_of_nodes
  health_check_type   = "EC2"

  termination_policies = ["NewestInstance"]

  target_group_arns = [aws_lb_target_group.swarm.arn]

  tag {
    key                 = "Name"
    value               = local.manager_tag
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.swarm_node.id
    version = "$Latest"
  }
  depends_on = [aws_ssm_parameter.swarm_token]

}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "45"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-usage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "35"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

resource "aws_cloudwatch_event_rule" "autoscaling_terminate_event_rule" {
  name        = "autoscaling-terminate-event-rule"
  description = "Trigger on autoscaling termination events"
  event_pattern = jsonencode({
    source        = ["aws.autoscaling"],
    "detail-type" = ["EC2 Instance Terminate Successful"],
    detail = {
      AutoScalingGroupName = [aws_autoscaling_group.main.name]
    }
  })
}

resource "aws_cloudwatch_event_target" "stop_instances" {
  target_id = "SwarmLeave"
  arn       = "arn:aws:ssm:eu-west-1::document/AWS-RunShellScript"
  input = jsonencode({
    commands = [
      "DOWN_NODE_IDS=$(docker node ls | grep 'Down' | awk '{print $1}')",
      "docker node demote $DOWN_NODE_IDS",
      "docker node rm $DOWN_NODE_IDS",
      "NODES=$(docker node ls | awk 'NR > 1' | wc -l)",
      "docker service update kanban_web --replicas $NODES"
    ],
  })

  rule     = aws_cloudwatch_event_rule.autoscaling_terminate_event_rule.name
  role_arn = aws_iam_role.event_bridge_role.arn

  run_command_targets {
    key    = "tag:Name"
    values = ["docker-swarm-manager"]
  }
}
