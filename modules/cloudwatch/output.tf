output "log_group_name" {

  value = aws_cloudwatch_log_group.enterprise.name

}

output "log_group_arn" {

  value = aws_cloudwatch_log_group.enterprise.arn

}

output "cloudtrail_name" {

  value = aws_cloudtrail.main.name

}

output "cloudwatch_log_group" {

  value = aws_cloudwatch_log_group.trail.name

}

output "cloudtrail_arn" {

  value = aws_cloudtrail.main.arn

}