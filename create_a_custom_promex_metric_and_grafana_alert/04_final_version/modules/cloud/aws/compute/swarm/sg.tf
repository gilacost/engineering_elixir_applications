# in modules/cloud/aws/compute/swarm/sg.tf

resource "aws_security_group" "swarm_sg" {
  vpc_id = data.aws_vpc.main.id

  ingress {
    description = "Elixir Phoenix app"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker swarm management"
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker container network discovery"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }

  ingress {
    description = "Docker overlay network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
