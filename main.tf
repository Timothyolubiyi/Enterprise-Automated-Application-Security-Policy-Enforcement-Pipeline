#############################################
# VPC (CORE NETWORK ONLY)
#############################################
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = var.vpc_cidr
  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn

  subnet_cidrs = [
    var.public_subnet_cidr,
    var.private_subnet1_cidr,
    var.private_subnet2_cidr
  ]

  availability_zones = [
    var.public_az,
    var.private_az1,
    var.private_az2
  ]
}

#############################################
# SUBNETS
#############################################
module "subnet" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id

  public_cidr   = var.public_subnet_cidr
  private1_cidr = var.private_subnet1_cidr
  private2_cidr = var.private_subnet2_cidr

  public_az   = var.public_az
  private1_az = var.private_az1
  private2_az = var.private_az2
}

#############################################
# INTERNET GATEWAY
#############################################
module "igw" {
  source = "./modules/igw"

  vpc_id = module.vpc.vpc_id
}

#############################################
# NAT GATEWAY
#############################################
module "nat" {
  source = "./modules/nat"

  public_subnet_id = module.subnet.public_subnet_id
  igw_id           = module.igw.igw_id
}

#############################################
# ROUTES
#############################################
module "route" {
  source = "./modules/route"

  vpc_id = module.vpc.vpc_id

  igw_id         = module.igw.igw_id
  nat_gateway_id = module.nat.nat_id

  public_subnet_ids = [
    module.subnet.public_subnet
  ]
  private_subnet_ids = module.subnet.private_subnet_ids
}

#############################################
# SECURITY GROUPS
#############################################
module "securitygroup" {
  source = "./modules/securitygroup"

  vpc_id = module.vpc.vpc_id
}

#############################################
# KMS
#############################################
module "kms" {
  source = "./modules/kms"

  environment = var.environment
}

#############################################
# S3 STATE / CLOUDTRAIL BUCKET
#############################################
module "s3" {
  source = "./modules/s3"

  bucket_name = "enterprise-devsecops-tfstate"
  environment = var.environment
  kms_key_arn = module.kms.kms_key_arn
}

#############################################
# DYNAMODB LOCK TABLE
#############################################
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = "terraform-state-lock"
  kms_key_arn = module.kms.kms_key_arn
}

#############################################
# IAM
#############################################
module "iam" {
  source = "./modules/iam"

  github_owner = "your-github-username"
  github_repo  = "enterprise-devsecops"
  cloudwatch_log_group_arn = module.cloudwatch.log_group_arn
}

#############################################
# SECRETS MANAGER
#############################################
module "secretsmanager" {
  source = "./modules/secretsmanager"

  secret_name = "enterprise-db-secret"
  description = "Database Credentials"
  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn

  username = "admin"
  password = var.db_password
}

#############################################
# ECR
#############################################
module "ecr" {
  source = "./modules/ecr"

  repository_name = "enterprise-devsecops"
  environment     = var.environment

  kms_key_arn = module.kms.kms_key_arn

}

#############################################
# EKS (FIXED)
#############################################
module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  eks_version  = var.eks_version

  cluster_role_arn = module.iam.eks_cluster_role_arn

  subnet_ids = module.subnet.private_subnet_ids

  kms_key_arn = module.kms.kms_key_arn
}

#############################################
# EC2
#############################################
module "ec2" {
  source = "./modules/ec2"

  instance_type = "t3.medium"

  private_subnet = module.subnet.private_subnet1
  security_group = module.securitygroup.security_group_id

  kms_key_arn = module.kms.kms_key_arn
  environment = var.environment

  instance_profile = module.iam.ec2_instance_profile
}

#############################################
# CLOUDWATCH / CLOUDTRAIL
#############################################
module "cloudtrail" {
  source = "./modules/cloudtrail"

  trail_name     = "enterprise-audit-trail"
  s3_bucket_name = module.s3.bucket_name

  kms_key_arn = module.kms.kms_key_arn

  cloudwatch_log_group_arn = module.cloudwatch.log_group_arn

  retention_days = 30
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  log_group_name = "/aws/enterprise/devsecops"

  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn
}