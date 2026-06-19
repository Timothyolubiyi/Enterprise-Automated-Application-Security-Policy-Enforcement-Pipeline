resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/devsecops"

  retention_in_days = 30

  kms_key_id = module.kms.kms_key_arn

}


#############################################
# CloudWatch Log Group
#############################################

resource "aws_cloudwatch_log_group" "enterprise" {

  name = var.log_group_name

  retention_in_days = var.retention_days

  kms_key_id = var.kms_key_arn

  tags = {

    Name = var.log_group_name

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}

#############################################
# Log Stream
#############################################

resource "aws_cloudwatch_log_stream" "stream" {

  name = "default"

  log_group_name = aws_cloudwatch_log_group.enterprise.name

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

          "logs:PutLogEvents"

        ]

        Resource = "*"

      }

    ]

  })

}

#############################################
# CloudTrail
#############################################

resource "aws_cloudtrail" "main" {

  name = var.trail_name

  s3_bucket_name = var.s3_bucket_name

  is_multi_region_trail = true

  include_global_service_events = true

  enable_log_file_validation = true

  kms_key_id = var.kms_key_arn

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.trail.arn}:*"

  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_role.arn

  depends_on = [

    aws_cloudwatch_log_group.trail

  ]

}

#############################################
# CloudWatch Log Group for CloudTrail
#############################################

resource "aws_cloudwatch_log_group" "trail" {

  name = "/aws/cloudtrail/${var.trail_name}"

  retention_in_days = var.retention_days

  kms_key_id = var.kms_key_arn

  tags = {

    Name = var.trail_name

    ManagedBy = "Terraform"

  }

}