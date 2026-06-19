variable "project_name" {

  description = "Project Name"

  type = string

  default = "Enterprise-DevSecOps"

}

variable "environment" {

  description = "Deployment Environment"

  type = string

  default = "dev"

}

variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "eu-north-1"

}

variable "vpc_cidr" {

  description = "VPC CIDR"

  type = string

  default = "10.0.0.0/16"

}

variable "public_subnet_cidr" {

  type = string

  default = "10.0.1.0/24"

}

variable "private_subnet1_cidr" {

  type = string

  default = "10.0.2.0/24"

}

variable "private_subnet2_cidr" {

  type = string

  default = "10.0.3.0/24"

}

variable "public_az" {

  type = string

  default = "eu-west-1a"

}

variable "private_az1" {

  type = string

  default = "eu-west-1b"

}

variable "private_az2" {

  type = string

  default = "eu-west-1c"

}


variable "cloudwatch" {
  type = string
}

variable "cloudtrail_bucket_name" {
  type = string
}