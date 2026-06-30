variable "vpc_cidr" {}
variable "environment" {}
variable "subnet_cidrs" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}

variable "kms_key_arn" {
  description = "KMS Key ARN used to encrypt CloudWatch Log Groups"
  type        = string
}