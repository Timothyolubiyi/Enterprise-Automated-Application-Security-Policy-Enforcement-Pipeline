resource "aws_security_group" "main" {
  name        = "enterprise-sg"
  description = "Enterprise security group for application access"
  vpc_id      = var.vpc_id

  # Restrict HTTPS to specific networks
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    description     = "HTTPS from internal network"
  }
  

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    description     = "HTTP from allowed networks"
  }

   #Remove SSH access or restrict to specific IPs
   # Restrict SSH to bastion or specific IPs only
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]  # Replace with bastion CIDR or remove entirely
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