# START: event_bridge_ec2_permissions
# START: event_bridge_event_permissions
# in modules/cloud/aws/compute/swarm/iam.tf

# END: event_bridge_ec2_permissions
# END: event_bridge_event_permissions
locals {
  ssm_arn = "arn:aws:ssm:${var.region}:${var.account_id}:parameter/docker/*"
}

# START: event_bridge_ec2_permissions
resource "aws_iam_policy" "ssm_policy" {
  # END: event_bridge_ec2_permissions
  name        = "DockerSwarmSSMPolicy"
  description = "Docker Swarm Policy"

  # START: event_bridge_ec2_permissions
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # END: event_bridge_ec2_permissions
      {
        Sid      = "SSMPutParameter",
        Effect   = "Allow",
        Action   = "ssm:PutParameter",
        Resource = local.ssm_arn
      },
      {
        Sid      = "SSMGetParameter",
        Effect   = "Allow",
        Action   = "ssm:GetParameter",
        Resource = local.ssm_arn
      },
      {
        Sid      = "EC2DescribeInstances",
        Effect   = "Allow",
        Action   = "ec2:DescribeInstances",
        Resource = "*"
      },
      {
        Sid      = "EC2CreateTags",
        Effect   = "Allow",
        Action   = "ec2:CreateTags",
        Resource = "*"
      },
      # START: event_bridge_ec2_permissions
      {
        Sid    = "EventBridge",
        Effect = "Allow",
        Action = [
          "ssm:UpdateInstanceInformation",
          "ec2messages:*"
        ],
        Resource = "*"
      }
    ]
  })
}
# END: event_bridge_ec2_permissions

resource "aws_iam_role" "ssm_role" {
  name = "DockerSwarmSSMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
  policy_arn = aws_iam_policy.ssm_policy.arn
  role       = aws_iam_role.ssm_role.name
}

resource "aws_iam_instance_profile" "main_profile" {
  name = "DockerSwarmSSMInstanceProfile"
  role = aws_iam_role.ssm_role.name
}

# START: event_bridge_event_permissions
resource "aws_iam_policy" "event_bridge_policy" {
  name        = "EventBridgePolicy"
  description = "Event Bridge"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "EventBridgeSendSSMCommand",
        Effect   = "Allow",
        Action   = "ssm:SendCommand",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "event_bridge_role" {
  name = "EventBridgeRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "event_bridge_attachment" {
  policy_arn = aws_iam_policy.event_bridge_policy.arn
  role       = aws_iam_role.event_bridge_role.name
}
# END: event_bridge_event_permissions
