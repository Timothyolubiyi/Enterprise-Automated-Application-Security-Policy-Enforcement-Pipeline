resource "aws_cloudtrail" "this" {

  name           = var.trail_name
  s3_bucket_name = var.s3_bucket_name
  kms_key_id     = var.kms_key_arn
  sns_topic_name = aws_sns_topic.cloudtrail_alerts.name

  enable_logging                = true
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.trail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_role.arn
}

#############################################
# IAM Role for CloudTrail → CloudWatch Logs
#############################################

resource "aws_iam_role" "cloudtrail_role" {

  name = "cloudtrail-cloudwatch-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "cloudtrail.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}



resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "cloudtrail-cloudwatch-policy"
  role = aws_iam_role.cloudtrail_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "${aws_cloudwatch_log_group.trail.arn}:*"  # Specific resource
      }
    ]
  })
}


#############################################
# CloudWatch Log Group for CloudTrail
#############################################

resource "aws_cloudwatch_log_group" "trail" {
  name              = "/aws/cloudtrail/${var.trail_name}"
  retention_in_days = 365  # 1 year minimum
  kms_key_id        = var.kms_key_arn  # Add KMS encryption
  
  tags = {
    Name        = var.trail_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic" "cloudtrail_alerts" {
  name = "cloudtrail-alerts"

  kms_master_key_id = var.kms_key_arn
}
