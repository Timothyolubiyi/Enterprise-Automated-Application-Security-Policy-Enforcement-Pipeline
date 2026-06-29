For Enterprise DevSecOps & Cloud Security Project, Wazuh should run on a dedicated EC2 instance inside a private subnet, with access controlled through a bastion host or VPN. This is more secure than placing it directly in a public subnet.

# Directory Structure

terraform/
│
└── modules/
      └── ec2/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf


# Security Group Recommendations

Allow only the ports you actually need.

# Port	                         Purpose
22	                            SSH (restricted to your IP or bastion host)
443	                            Wazuh Dashboard (HTTPS)
1514	                        Wazuh Agent Events
1515	                        Agent Registration
55000	                        Wazuh API
9200	                        OpenSearch (internal only)

Avoid exposing these ports to 0.0.0.0/0 unless absolutely necessary.


# Architecture

GitHub Actions
        │
        ▼
Terraform Apply
        │
        ▼
Private Subnet
        │
        ▼
EC2 (Ubuntu)
        │
        ▼
Wazuh Manager
        │
        ├────────► Filebeat
        │
        ├────────► OpenSearch
        │
        └────────► Wazuh Dashboard
                     │
                     ▼
         Receives Alerts from:
              • EKS
              • EC2
              • CloudTrail
              • Trivy
              • GitHub Actions



# Recommendation for your project

Since your goal is a fully automated DevSecOps platform, a good next step is to replace the manual user_data installation with Terraform-managed provisioning that:

Creates the EC2 instance.
Installs Wazuh automatically.
Configures Filebeat and the Wazuh API.
Registers EKS worker nodes and EC2 instances as Wazuh agents.
Forwards CI/CD security scan results (Trivy, Semgrep, Checkov, Gitleaks) into Wazuh for centralized monitoring.