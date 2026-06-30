resource "aws_secretsmanager_secret" "secret" {
  name        = var.secret_name
  description = var.description
  kms_key_id  = var.kms_key_arn

  recovery_window_in_days = 30

  # Add rotation configuration
  #rotation_rules {
  #  automatically_after_days = 30
  #}

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = var.secret_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "random_password" "secret" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret_version" "secret_value" {

  secret_id = aws_secretsmanager_secret.secret.id

  secret_string = jsonencode({
    username = var.username
    password = random_password.secret.result
  })
}