output "public_subnet" {
  value = aws_subnet.public.id
}

output "private_subnet1" {
  value = aws_subnet.private1.id
}

output "private_subnet2" {
  value = aws_subnet.private2.id
}