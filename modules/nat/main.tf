resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = var.public_subnet_id

  depends_on = [aws_eip.nat]

  tags = {
    Name = "MainNAT"
  }
}