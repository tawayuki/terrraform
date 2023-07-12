variable "db_sg_config" {
  type = object({
    name        = string
    protocol    = string
    port        = list(number)
    cidr_blocks = list(string)
    vpc_id      = string
  })
}
