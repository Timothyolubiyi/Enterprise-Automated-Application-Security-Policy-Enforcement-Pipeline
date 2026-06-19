# Authentication Flow

Developer Push
       │
       ▼
GitHub Repository
       │
       ▼
GitHub Actions
       │
       ▼
Requests OIDC Token
       │
       ▼
   AWS STS
       │
       ▼
Assume GitHubActionsOIDCRole
       │
       ▼
Temporary AWS Credentials
       │
       ▼
Terraform Deploys Infrastructure    



This pattern avoids storing AWS access keys in GitHub Secrets and aligns with modern enterprise CI/CD practices. The next logical enhancement is to split permissions into multiple OIDC roles (for example, separate roles for Terraform infrastructure deployment, ECR image publishing, and EKS application deployment) so each GitHub workflow receives only the permissions it requires.

# Purpose of deploy.yml

The deploy.yml file tells GitHub Actions what to do when code is pushed to the repository.

Typical steps include:

- Checkout the repository
- Authenticate to AWS using OIDC

# Commands to deploy to GithubAction

Run terraform init
Run terraform validate
Run terraform plan
Run security scans (Checkov, Trivy, Semgrep, Gitleaks)
Run terraform apply


# What is does, it:
Build the Docker image
Push the image to ECR
Deploy the application to EKS

So:

✅ terraform/ contains your Infrastructure-as-Code files.
✅ .github/workflows/deploy.yml contains your CI/CD automation.



