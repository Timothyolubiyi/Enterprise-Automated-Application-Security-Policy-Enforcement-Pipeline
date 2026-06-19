resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  depends_on = [var.igw_id]

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
}

resource "aws_subnet" "this" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  map_public_ip_on_launch = true
}

resource "aws_security_group" "this" {
  name   = "app-sg"
  vpc_id = var.vpc_id
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