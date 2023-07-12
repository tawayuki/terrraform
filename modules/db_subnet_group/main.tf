resource "aws_db_subnet_group" "db_sub" {
  name       = var.name
  subnet_ids = var.subnet_ids
}
