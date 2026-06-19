variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "environment" {

  type = string

}

variable "log_group_name" {

  description = "CloudWatch Log Group Name"

  type = string

}