output "iam_role_arn" {
  value = aws_iam_role.iam-role.arn
}

output "iam_role_name" {
  value = aws_iam_role.iam-role.name
}

output "instanceprofile" {
  value = aws_iam_instance_profile.ec2-role.name
}

