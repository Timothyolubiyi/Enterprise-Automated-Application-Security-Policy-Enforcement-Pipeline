resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.this[0].id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "this" {

  count = length(var.subnet_cidrs)

  vpc_id = aws_vpc.this.id

  cidr_block = var.subnet_cidrs[count.index]

  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_security_group" "this" {
  name   = "app-sg"
  vpc_id = aws_vpc.this.id
}

# Restrict default security group
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "default-sg-restricted"
  }
  # All ingress/egress rules are implicitly empty
}

# Attach security groups to resources (example for EKS)
# Update your module calls to attach security groups to ENIs/instances

#############################################
# IAM Role for VPC Flow Logs
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
        Resource = "${aws_cloudwatch_log_group.vpc_flow.arn}:*"  # Specific resource
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

resource "aws_flow_log" "this" {

  iam_role_arn = aws_iam_role.flow_logs.arn

  log_destination = aws_cloudwatch_log_group.vpc_flow.arn

  traffic_type = "ALL"

  vpc_id = aws_vpc.this.id

}

resource "aws_cloudwatch_log_group" "vpc_flow" {
  name              = "/aws/vpc/flowlogs"
  retention_in_days = 365  # CKV_AWS_338: At least 1 year
  kms_key_id        = var.kms_key_arn  # CKV_AWS_158: Encryption
}
