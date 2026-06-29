For an enterprise DevSecOps project, the recommended approach is to use GitHub Actions OpenID Connect (OIDC) to assume an AWS IAM role. This eliminates the need to store long-lived AWS access keys as GitHub secrets.

enterprise-devsecops/
│
|
└── modules/
      └── iam/
            ├── main.tf
            ├──least-privilege-policy.tf
            ├── variables.tf
            └── outputs.tf