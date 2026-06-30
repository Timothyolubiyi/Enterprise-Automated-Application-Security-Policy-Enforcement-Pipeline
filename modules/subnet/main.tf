resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidr
  availability_zone = var.public_az
  # Remove: map_public_ip_on_launch = true
  # Or use: map_public_ip_on_launch = var.assign_public_ip  # default to false

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private1" {

  vpc_id = var.vpc_id

  cidr_block = var.private1_cidr

  availability_zone = var.private1_az

  tags = {
    Name = "PrivateSubnet1"
  }

}

resource "aws_subnet" "private2" {

  vpc_id = var.vpc_id

  cidr_block = var.private2_cidr

  availability_zone = var.private2_az

  tags = {
    Name = "PrivateSubnet2"
  }

}