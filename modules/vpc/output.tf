output "vpc_id" {
  value = aws_vpc.main.id
}

output "flow_log_id" {

  value = aws_flow_log.vpc.id

}

output "flow_log_arn" {

  value = aws_flow_log.vpc.arn

}
