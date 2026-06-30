output "kms_key_id" {

  value = aws_kms_key.this.id

}

output "kms_key_arn" {
  description = "KMS Key ARN"

  value = aws_kms_key.this.arn
}
