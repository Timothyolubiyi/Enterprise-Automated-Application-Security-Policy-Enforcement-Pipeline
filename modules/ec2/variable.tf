
variable "instance_type" {

  type = string

  default = "t3.medium"

}

variable "private_subnet" {

  type = string

}

variable "security_group" {

  type = string

}

variable "kms_key_arn" {

  type = string

}

variable "environment" {

  type = string

}

variable "instance_profile" {

  type = string

}