resource "aws_kms_key" "this" {

  description = "Enterprise DevSecOps KMS Key"

  deletion_window_in_days = 30

  enable_key_rotation = true

  tags = {

    Name = "Enterprise-KMS"

    Environment = var.environment

  }

}

resource "aws_kms_alias" "alias" {

  name = "alias/enterprise-devsecops"

  target_key_id = aws_kms_key.this.key_id

}