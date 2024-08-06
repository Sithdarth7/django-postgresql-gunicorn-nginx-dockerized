resource "aws_lb" "main" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["<SECURITY_GROUP_ID>"]
  subnets            = ["<SUBNET_ID1>", "<SUBNET_ID2>"]

  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
}

resource "aws_lb_target_group" "web" {
  name     = "web-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = "<VPC_ID>"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
