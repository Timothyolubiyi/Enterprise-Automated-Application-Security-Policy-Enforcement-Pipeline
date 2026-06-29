variable "bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN for S3 encryption"
}