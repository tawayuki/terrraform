resource "aws_lb" "alb" {
  name               = var.lb_base_config.Name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = var.lb_base_config.public_subnet_id
}

resource "aws_alb_target_group" "alb_tgw" {
  name     = var.lb_base_config.Name
  port     = var.lb_target_config.port
  protocol = var.lb_target_config.protocol
  vpc_id   = var.lb_target_config.vpc_id

  health_check {
    interval            = 30
    path                = var.lb_target_config.path
    port                = var.lb_target_config.port
    protocol            = var.lb_target_config.protocol
    timeout             = 5
    unhealthy_threshold = 1
    matcher             = 200
  }
}

resource "aws_alb_target_group_attachment" "alb" {
  count            = 1
  target_group_arn = aws_alb_target_group.alb_tgw.arn
  target_id        = element(var.target_id, count.index)
  port             = var.lb_target_config.port
}

resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = var.lb_listener_config.port
  protocol          = var.lb_listener_config.protocol

    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_tgw.arn
  }
}

