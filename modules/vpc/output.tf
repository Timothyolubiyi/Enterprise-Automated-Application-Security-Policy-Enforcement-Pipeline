output "vpc_id" {
  value = aws_vpc.this.id
}

output "flow_log_id" {
  value = aws_flow_log.this.id
}

output "flow_log_arn" {
  value = aws_flow_log.this.arn
}

output "public_subnet_ids" {
  value = aws_subnet.this[*].id
}


output "subnet_ids" {
  value = aws_subnet.this[*].id
}