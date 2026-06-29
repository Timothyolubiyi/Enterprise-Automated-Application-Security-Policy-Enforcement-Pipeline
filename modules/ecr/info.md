# Directory Structure
terraform/
│
└── modules/
      └── ecr/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf



# Deployment Order

KMS
 │
 ▼
ECR Repository
 │
 ▼
Image Scan on Push
 │
 ▼
GitHub Actions Build
 │
 ▼
Docker Push to ECR
 │
 ▼
Automatic Vulnerability Scan
 │
 ▼
Trivy + Wazuh + Security Dashboard



# Enterprise enhancements

For a stronger enterprise implementation, consider adding:

Repository policy restricting pushes and pulls to specific IAM roles.
Cross-account access for shared deployment pipelines if needed.
Enhanced scanning (via Amazon Inspector integration where supported) for continuous vulnerability assessment in addition to basic scan-on-push.
Image signing and verification as part of your CI/CD pipeline for supply chain security.

This module integrates cleanly with the KMS module you created earlier and is suitable for a secure DevSecOps pipeline on AWS.