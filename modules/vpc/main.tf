resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}



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

#############################################
# IAM Role for VPC Flow Logs
#############################################

resource "aws_iam_role" "flow_logs" {

  name = "${var.environment}-vpc-flowlogs-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "vpc-flow-logs.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

#############################################
# IAM Policy
#############################################

resource "aws_iam_role_policy" "flow_logs" {

  name = "${var.environment}-flowlogs-policy"

  role = aws_iam_role.flow_logs.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"

        ]

        Resource = "*"

      }

    ]

  })

}

#############################################
# VPC Flow Logs
#############################################

resource "aws_flow_log" "vpc_flow_logs" {

  vpc_id = aws_vpc.main.id

  traffic_type = "ALL"

  log_destination_type = "cloud-watch-logs"

  log_group_name = var.log_group_name

  iam_role_arn = aws_iam_role.flow_logs.arn

}