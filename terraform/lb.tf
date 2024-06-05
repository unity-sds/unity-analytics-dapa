# target group
resource "aws_lb_target_group" "unity_dapa_tg" {
  name        = "unity-dapa-tg"
  port        = 8080
  protocol    = "TCP"
  target_type = "instance"
  #vpc_id      = data.aws_vpc.default.id
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    protocol            = "HTTP"
    port                = 8080
    path                = "/unity/v0/openapi.json"
    interval            = 30
    timeout             = 10
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "unity_dapa_tg"
  }
}

# attach instance
resource "aws_lb_target_group_attachment" "unity_dapa_tg_attachment" {
  target_group_arn = aws_lb_target_group.unity_dapa_tg.arn
  target_id        = aws_instance.unity_dapa_instance.id
  port             = 8080
}

# create alb
resource "aws_lb" "unity-dapa-lb" {
  name               = "unity-dapa-lb"
  load_balancer_type = "network"
  internal           = true
  #security_groups    = [var.sg_id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  #access_logs {
  #  bucket  = "tbd"
  #  prefix  = "dapa/tbd/unity-dapa-lb"
  #  enabled = true
  #}

  tags = {
    Name = "unity-dapa-lb"
  }
}

resource "aws_lb_listener" "unity_dapa_lb_listener" {
  load_balancer_arn = aws_lb.unity-dapa-lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.unity_dapa_tg.arn
  }

  tags = {
    Name = "unity_dapa_lb_listener"
  }
}
