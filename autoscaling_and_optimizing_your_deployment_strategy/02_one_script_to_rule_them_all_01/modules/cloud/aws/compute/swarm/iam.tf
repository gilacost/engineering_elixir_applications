# in modules/cloud/aws/compute/swarm/iam.tf

locals {
  ssm_arn = "arn:aws:ssm:${var.region}:${var.account_id}:parameter/docker/*"
}

resource "aws_iam_policy" "ssm_policy" {
  name        = "DockerSwarmSSMPolicy"
  description = "Policy to PUT and GET parameters from SSM for Docker Swarm"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
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
      }
    ]
  })
}

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

