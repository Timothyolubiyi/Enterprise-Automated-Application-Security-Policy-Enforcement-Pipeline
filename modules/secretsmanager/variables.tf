variable "secret_name" {
  description = "Secret Name"
  type        = string
}

variable "description" {
  description = "Secret Description"
  type        = string
  default     = "Managed by Terraform"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

variable "username" {
  description = "Application username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Application password"
  type        = string
  sensitive   = true
}