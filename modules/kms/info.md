# AWS KMS (KEY MANAGEMENT SERVICE) MODULE

Using AWS KMS is the recommended enterprise approach because it lets you control encryption keys and audit their usage through AWS services.

For your DevSecOps project, KMS can be used to encrypt:

✅ Terraform state in S3
✅ EBS volumes
✅ ECR repositories
✅ CloudWatch logs
✅ Secrets Manager secrets
✅ S3 buckets
✅ RDS databases (if added later)


# Project Structure

terraform/
│
└── modules/
      └── kms/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf


# Security recommendation

For a real enterprise deployment, avoid hardcoding secrets such as usernames and passwords in Terraform files or terraform.tfvars. Instead:

Generate passwords with the random_password resource.
Or inject secret values securely from your CI/CD pipeline (for example, GitHub Actions secrets or another secure secret source) at deployment time.
Restrict IAM permissions so only authorized workloads and administrators can read the secret.

This module is suitable for storing application credentials, API keys, database passwords, or other sensitive configuration while using your AWS KMS key for encryption.