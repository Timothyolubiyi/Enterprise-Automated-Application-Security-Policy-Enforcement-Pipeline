variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "enterprise-devsecops"
}

variable "environment" {

  type = string

}

variable "kms_key_arn" {
  description = "KMS key for ECR encryption"
  type        = string
}
