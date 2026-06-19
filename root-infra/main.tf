module "vpc" {

  source = "./modules/vpc"

  cidr = "10.0.0.0/16"

  name = "EnterpriseVPC"

}

module "subnet" {

  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id

  public_cidr = "10.0.1.0/24"

  private1_cidr = "10.0.2.0/24"

  private2_cidr = "10.0.3.0/24"

  public_az = "eu-west-1a"

  private1_az = "eu-west-1b"

  private2_az = "eu-west-1c"

}

module "igw" {

  source = "./modules/igw"

  vpc_id = module.vpc.vpc_id

}

module "nat" {

  source = "./modules/nat"

  public_subnet = module.subnet.public_subnet

}

module "route" {

  source = "./modules/route"

  vpc_id = module.vpc.vpc_id

  igw = module.igw.igw_id

  nat = module.nat.nat_id

  public_subnet = module.subnet.public_subnet

  private1 = module.subnet.private_subnet1

  private2 = module.subnet.private_subnet2

}

module "securitygroup" {

  source = "./modules/securitygroup"

  vpc_id = module.vpc.vpc_id

}

module "s3" {

  source = "./modules/s3"

  bucket_name = "enterprise-devsecops-tfstate"

  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn

}

module "dynamodb" {

  source = "./modules/dynamodb"

  table_name = "terraform-state-lock"

}

module "iam" {

  source = "./modules/iam"

  github_owner = "your-github-username"

  github_repo = "enterprise-devsecops"

}

module "kms" {

  source = "./modules/kms"

  environment = var.environment

}

module "ec2" {

  source = "./modules/ec2"

  kms_key_arn = module.kms.kms_key_arn

}

module "secretsmanager" {

  source = "./modules/secretsmanager"

  secret_name = "enterprise-db-secret"

  description = "Database Credentials"

  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn

  username = "admin"

  password = "ChangeMe123!"

}

module "ecr" {

  source = "./modules/ecr"

  repository_name = "enterprise-devsecops-app"

  environment = var.environment

  kms_key_arn = module.kms.kms_key_arn

}

module "eks" {

  source = "./modules/eks"

  cluster_name = "enterprise-devsecops"

  eks_version = "1.32"

  private_subnets = [

    module.subnet.private_subnet1,

    module.subnet.private_subnet2

  ]

  kms_key_arn = module.kms.kms_key_arn

}

module "ec2" {

  source = "./modules/ec2"

  instance_type = "t3.large"

  private_subnet = module.subnet.private_subnet1

  security_group = module.securitygroup.security_group_id

  kms_key_arn = module.kms.kms_key_arn

  environment = var.environment

  instance_profile = module.iam.ec2_instance_profile

}

module "cloudwatch" {

  source = "./modules/cloudwatch"

  log_group_name = "/enterprise/devsecops"

  retention_days = 30

  kms_key_arn = module.kms.kms_key_arn

  environment = var.environment

}

module "cloudwatch" {

  source = "./modules/cloudwatch"

  cluster_name = module.eks.cluster_name

  log_group_name = "/enterprise/devsecops"

  retention_days = 30

  kms_key_arn = module.kms.kms_key_arn

  environment = var.environment

}

module "vpc" {

  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr

  environment = var.environment

  log_group_name = module.cloudwatch.log_group_name

}

module "cloudtrail" {

  source = "./modules/cloudtrail"

  trail_name = "enterprise-audit-trail"

  s3_bucket_name = module.s3.bucket_name

  kms_key_arn = module.kms.kms_key_arn

  retention_days = 30

}