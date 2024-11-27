# START: lb_security_group
# START: lb_target_group
# START: lb_load_balancer
# START: lb_listener
# in modules/cloud/aws/compute/swarm/lb.tf

# END: lb_security_group
# END: lb_target_group
# END: lb_listener
resource "aws_lb" "main" {
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  name               = "swarm-load-balancer"
  security_groups    = [aws_security_group.http.id]
  subnets            = data.aws_subnets.main_subnets.ids
}
# END: lb_load_balancer

# START: lb_target_group
resource "aws_lb_target_group" "swarm" {
  ip_address_type               = "ipv4"
  load_balancing_algorithm_type = "round_robin"
  name                          = "docker-swarm-target-group"
  port                          = 4000
  protocol                      = "HTTP"
  vpc_id                        = data.aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "302"
    path                = "/"
    port                = "4000"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}
# END: lb_target_group

# START: lb_listener
resource "aws_lb_listener" "http" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.main.arn

  default_action {
    target_group_arn = aws_lb_target_group.swarm.arn
    type             = "forward"
  }
}
# END: lb_listener

# START: lb_security_group
resource "aws_security_group" "http" {
  name        = "allow_http"
  description = "Allow http traffic"

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# END: lb_security_group
