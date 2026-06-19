#############################################
# AWS Secrets Manager Secret
#############################################

resource "aws_secretsmanager_secret" "secret" {

  name                    = var.secret_name

  description             = var.description

  kms_key_id              = var.kms_key_arn

  recovery_window_in_days = 7

  tags = {

    Name        = var.secret_name

    Environment = var.environment

    ManagedBy   = "Terraform"

  }

}

#############################################
# Initial Secret Value
#############################################

resource "aws_secretsmanager_secret_version" "secret_value" {

  secret_id = aws_secretsmanager_secret.secret.id

  secret_string = jsonencode({

    username = var.username

    password = var.password

  })

}