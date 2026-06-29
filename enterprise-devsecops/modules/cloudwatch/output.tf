output "log_group_name" {

  value = aws_cloudwatch_log_group.enterprise.name

}

output "log_group_arn" {

  value = aws_cloudwatch_log_group.enterprise.arn

}