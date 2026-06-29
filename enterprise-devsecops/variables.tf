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

  default = "eu-north-1a"

}

variable "private_az1" {

  type = string

  default = "eu-north-1b"

}

variable "private_az2" {

  type = string

  default = "eu-north-1c"

}


variable "enable_cloudwatch" {
  type    = bool
  default = true
}

############################################
# CloudWatch retention
############################################

variable "retention_days" {
  description = "CloudWatch log retention"
  type        = number
  default     = 365
}

variable "cloudtrail_bucket_name" {
  type = string

}

variable "eks_version" {
  type    = string
  default = "1.29"
}

variable "cluster_name" {
  type    = string
  default = "enterprise-devsecops"
}

variable "db_password" {
  sensitive = true
}

############################################
# DynamoDB
############################################

variable "dynamodb_table_name" {
  description = "Terraform state lock table"
  type        = string
  default     = "terraform-locks"
}


############################################
# EC2 / Wazuh
############################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

############################################
# CloudTrail
############################################

variable "trail_name" {
  description = "CloudTrail name"
  type        = string
  default     = "enterprise-cloudtrail"
}

############################################
# S3 Backend
############################################

variable "terraform_state_bucket" {
  description = "Terraform state bucket"
  type        = string
}

############################################
# ECR
############################################

variable "repository_name" {
  description = "ECR Repository Name"
  type        = string
  default     = "enterprise-devsecops"
}

############################################
# Tags
############################################

variable "tags" {
  description = "Common tags"
  type        = map(string)

  default = {
    Project     = "Enterprise-DevSecOps"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "enterprise-devsecops"
}