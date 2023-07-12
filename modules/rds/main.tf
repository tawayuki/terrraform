resource "aws_db_instance" "db" {
  allocated_storage    = var.allocated_storage
  name              = var.name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  db_subnet_group_name = var.db_subnet_group_name
  identifier           = var.identifier
  multi_az             = var.multi_az
  vpc_security_group_ids = [var.vpc_security_group_ids]
}
