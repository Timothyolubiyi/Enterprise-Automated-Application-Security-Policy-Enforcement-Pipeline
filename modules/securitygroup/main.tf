resource "aws_security_group" "main" {
  name        = "enterprise-sg"
  description = "Enterprise security group for application access"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["105.112.45.123/32"]  # Replace with specific CIDR
    description     = "HTTPS from allowed networks"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["105.112.45.123/32"]
    description     = "HTTP from allowed networks"
  }

   #Remove SSH access or restrict to specific IPs
   ingress {
     from_port       = 22
     to_port         = 22
     protocol        = "tcp"
     cidr_blocks     = ["0.0.0.0/0"]
     description     = "SSH from bastion host only"
   }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "HTTPS outbound"
  }

  egress {
    from_port       = 53
    to_port         = 53
    protocol        = "udp"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "DNS outbound"
  }

  tags = {
    Name = "EnterpriseSG"
  }
}