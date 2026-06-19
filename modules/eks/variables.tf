variable "cluster_name" {

  type = string

}

variable "eks_version" {

  type = string

}

variable "private_subnets" {

  type = list(string)

}

variable "kms_key_arn" {

  type = string

}