variable "cidr" {}

variable "name" {}

variable "vpc_id" {

  description = "VPC ID"

  type = string

}

variable "environment" {

  type = string

}

variable "log_group_name" {

  description = "CloudWatch Log Group Name"

  type = string

}