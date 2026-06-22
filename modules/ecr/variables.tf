variable "repository_name" {

  description = "ECR Repository Name"

  type = string

}

variable "environment" {

  type = string

}

variable "kms_key_arn" {
  type = string
}
