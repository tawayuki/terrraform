resource "aws_acm_certificate" "ssl" {
  certificate_body = var.certificate_body
#  certificate_chain = var.certificate_chain
  private_key      = var.private_key
}
