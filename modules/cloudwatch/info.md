For Enterprise DevSecOps + Wazuh SIEM Project, CloudWatch should collect logs from:

✅ EKS Control Plane
✅ EC2 (Wazuh Server)
✅ VPC Flow Logs
✅ Application Logs
✅ GitHub Actions (optional via CloudWatch API)
✅ CloudTrail
✅ AWS Config (optional)

These logs can then be forwarded to Wazuh SIEM for centralized monitoring and correlation.

# Directory Structure

terraform/
│
└── modules/
      └── cloudwatch/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf

