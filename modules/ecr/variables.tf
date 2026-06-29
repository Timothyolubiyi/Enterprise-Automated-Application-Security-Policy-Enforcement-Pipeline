variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "enterprise-devsecops"
}

variable "environment" {

  type = string

}

variable "kms_key_arn" {
  type = string
}
