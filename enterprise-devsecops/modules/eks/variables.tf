variable "cluster_name" {

  type = string

}

variable "eks_version" {

  type = string

}

variable "kms_key_arn" {

  type = string

}

variable "cluster_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}