resource "aws_instance" "server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [var.sg_id]
  iam_instance_profile = var.iam_instance_profile
}

