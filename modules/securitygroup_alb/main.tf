resource "aws_security_group" "alb_sg" {
  name   = var.alb_sg_config.name
  vpc_id = var.alb_sg_config.vpc_id

  dynamic "ingress" {
    for_each = var.alb_sg_config.port

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.alb_sg_config.protocol
      cidr_blocks = var.alb_sg_config.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

