variable "trail_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

variable "retention_days" {
  type    = number
  default = 30
}

variable "cloudwatch_log_group_arn" {
  type = string
}