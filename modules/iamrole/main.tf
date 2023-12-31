
resource "aws_iam_role" "iam-role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode(var.iam_role_assume_role_policy)

  tags = {
    Name = var.iam_role_name
  }
}
resource "aws_iam_instance_profile" "ec2-role" {
  name = "test_profile"
  role = aws_iam_role.iam-role.name
}
