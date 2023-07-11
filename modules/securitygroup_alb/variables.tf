variable "alb_sg_config" {
  type = object({
    name        = string
    protocol    = string
    port        = list(number)
    vpc_id      = string
    cidr_blocks = list(string)
  })
}

