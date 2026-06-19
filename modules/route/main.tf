resource "aws_route_table" "public" {

  vpc_id = var.vpc_id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = var.igw

  }

}

resource "aws_route_table_association" "public_assoc" {

  subnet_id      = var.public_subnet

  route_table_id = aws_route_table.public.id

}

resource "aws_route_table" "private" {

  vpc_id = var.vpc_id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = var.nat

  }

}

resource "aws_route_table_association" "private1" {

  subnet_id      = var.private1

  route_table_id = aws_route_table.private.id

}

resource "aws_route_table_association" "private2" {

  subnet_id      = var.private2

  route_table_id = aws_route_table.private.id

}