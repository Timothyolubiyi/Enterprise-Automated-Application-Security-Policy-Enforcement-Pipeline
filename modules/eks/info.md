
For Enterprise DevSecOps Project, the EKS module should provision:

✅ EKS Cluster
✅ Managed Node Group
✅ IAM Roles
✅ Cluster Security Group
✅ Cluster Logging
✅ Private Subnets
✅ KMS Encryption for Kubernetes Secrets
✅ Auto Scaling
✅ Outputs for GitHub Actions


# Directory Structure
terraform/
│
└── modules/
      └── eks/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf

# Deployment Flow

Terraform Apply
       │
       ▼
IAM Roles
       │
       ▼
EKS Cluster
       │
       ▼
Private Subnets
       │
       ▼
Managed Node Group
       │
       ▼
Worker Nodes Join Cluster
       │
       ▼
GitHub Actions Deploys Application


# Enterprise recommendations

For a production-grade EKS deployment, consider these enhancements:

- Use private-only worker nodes in private subnets and restrict public endpoint access if possible.
- Enable all control plane logs (api, audit, authenticator, controllerManager, and scheduler) and send them to CloudWatch.
- Create a dedicated security group for the cluster and node groups instead of relying on defaults.
- Use multiple managed node groups (for example, system and application workloads) with labels and taints.
- Configure OIDC for IAM Roles for Service Accounts (IRSA) so Kubernetes pods can access AWS services without static credentials.
- Install the AWS Load Balancer Controller, Cluster Autoscaler, and Metrics Server as part of the cluster bootstrap process.

These additions will make the EKS environment much closer to what is commonly deployed in enterprise AWS environments.