
#############################################
# Ubuntu 24.04 LTS AMI
#############################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

}

#############################################
# Wazuh EC2 Instance
#############################################

resource "aws_instance" "wazuh" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  monitoring    = true
  ebs_optimized = true

  metadata_options {
  http_endpoint = "enabled"
  http_tokens   = "required"
}

  subnet_id = var.private_subnet

  user_data = file("${path.root}/scripts/bootstrap.sh")

  vpc_security_group_ids = [

    var.security_group
    

  ]


  iam_instance_profile = var.instance_profile

  associate_public_ip_address = false

  root_block_device {

    volume_size = 100

    volume_type = "gp3"

    encrypted = true

    kms_key_id = var.kms_key_arn

  }

  tags = {

    Name = "Wazuh-Server"

    Environment = var.environment

    ManagedBy = "Terraform"

  }

}