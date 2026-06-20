variable "log_group_name" {
  type = string
}

variable "retention_days" {
  type    = number
  default = 30
}

variable "kms_key_arn" {
  type = string
}

variable "environment" {
  type = string
}