output "public_subnet_ids" {
  value = [aws_subnet.public_subnet.id,aws_subnet.public_subnet2.id]
}

output "private_subnet1" {
  value = aws_subnet.private_subnet1.id
}
output "private_subnet2" {
  value = aws_subnet.private_subnet2.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

