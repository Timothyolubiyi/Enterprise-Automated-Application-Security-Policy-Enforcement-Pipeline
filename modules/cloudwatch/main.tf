#############################################
# Enterprise Log Group
#############################################

resource "aws_cloudwatch_log_group" "enterprise" {

  name              = var.log_group_name
  retention_in_days = var.retention_days
  kms_key_id        = var.kms_key_arn

  tags = {
    Name        = var.log_group_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

#############################################
# Default Stream
#############################################

resource "aws_cloudwatch_log_stream" "stream" {

  name           = "default"
  log_group_name = aws_cloudwatch_log_group.enterprise.name

}

#############################################
# EKS Log Group
#############################################

resource "aws_cloudwatch_log_group" "eks" {

  name              = "/aws/eks/devsecops"
  retention_in_days = var.retention_days
  kms_key_id        = var.kms_key_arn

}