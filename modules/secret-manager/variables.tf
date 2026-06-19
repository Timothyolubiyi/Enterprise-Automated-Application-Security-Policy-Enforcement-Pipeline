variable "secret_name" {

  description = "Secret Name"

  type = string

}

variable "description" {

  description = "Secret Description"

  type = string

  default = "Managed by Terraform"

}

variable "environment" {

  type = string

}

variable "kms_key_arn" {

  description = "KMS Key ARN"

  type = string

}

variable "username" {

  type = string

}

variable "password" {

  type = string

  sensitive = true

}