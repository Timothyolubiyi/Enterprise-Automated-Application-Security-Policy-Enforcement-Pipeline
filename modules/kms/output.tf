output "kms_key_id" {

  value = aws_kms_key.enterprise_key.id

}

output "kms_key_arn" {

  value = aws_kms_key.enterprise_key.arn

}