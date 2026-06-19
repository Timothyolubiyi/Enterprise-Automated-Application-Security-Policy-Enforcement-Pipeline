# Enterprise Automated Application Security Policy Enforcement Pipeline

## Overview

The **Enterprise Automated Application Security Policy Enforcement Pipeline** is a cloud-native DevSecOps platform that automates infrastructure provisioning, application security testing, policy enforcement, and security monitoring using Infrastructure as Code (IaC) and CI/CD best practices.

The project provisions AWS infrastructure with Terraform, deploys workloads to Amazon EKS, scans code and infrastructure for security issues, enforces security policies through Open Policy Agent (OPA), and forwards security events to Wazuh SIEM for centralized monitoring and incident response.

---

# Project Objectives

* Automate secure AWS infrastructure deployment using Terraform.
* Implement DevSecOps security scanning within GitHub Actions.
* Detect secrets, vulnerabilities, and IaC misconfigurations before deployment.
* Enforce security policies using Open Policy Agent (OPA).
* Deploy containerized applications to Amazon EKS.
* Integrate security events with Wazuh SIEM.
* Provide enterprise-grade cloud security architecture.

---

# Solution Architecture

```
                    Developer
                        │
                        ▼
                 GitHub Repository
                        │
                        ▼
                GitHub Actions CI/CD
                        │
 ┌───────────────┬───────────────┬───────────────┐
 ▼               ▼               ▼               ▼
Semgrep      Gitleaks        Checkov         Trivy
(SAST)       (Secrets)        (IaC)        (Containers)
                        │
                        ▼
               Open Policy Agent (OPA)
                        │
                 Policy Enforcement
                        │
             Pass ─────────────── Fail
              │                      │
              ▼                      ▼
      Terraform Deployment      Block Pipeline
              │
              ▼
      AWS Infrastructure
              │
 ┌────────────┼──────────────────────┐
 ▼            ▼                      ▼
VPC          EKS                   EC2 (Wazuh)
 │            │                      │
 │            ▼                      ▼
 │      Kubernetes Pods        Wazuh SIEM
 │                               │
 └──────────────► CloudWatch ◄────┘
                        │
                        ▼
          Slack / Email Security Alerts
```

---

# Technology Stack

## Cloud

* AWS
* Amazon VPC
* Amazon EKS
* Amazon EC2
* Amazon ECR
* Amazon S3
* AWS KMS
* AWS IAM
* CloudTrail
* CloudWatch
* Secrets Manager

## Infrastructure as Code

* Terraform

## CI/CD

* GitHub Actions

## Security

* Semgrep
* Gitleaks
* Trivy
* Checkov
* Open Policy Agent (OPA)
* Wazuh SIEM

## Containerization

* Docker
* Kubernetes

---

# Repository Structure

```
.
├── .github/
│   └── workflows/
│        └── devsecops-pipeline.yml
│
├── kubernetes/
│    ├── deployment.yaml
│    └── service.yaml
│
├── modules/
│    ├── vpc/
│    ├── subnet/
│    ├── igw/
│    ├── nat/
│    ├── route/
│    ├── securitygroup/
│    ├── s3/
│    ├── dynamodb/
│    ├── iam/
│    ├── kms/
│    ├── secretsmanager/
│    ├── ecr/
│    ├── eks/
│    ├── ec2/
│    ├── cloudwatch/
│    └── cloudtrail/
│
├── scans/
├── scripts/
├── backend.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── main.tf
└── README.md
```

---

# Security Pipeline

The pipeline performs automated security validation during every pull request and code push.

## Static Application Security Testing

* Semgrep

## Secrets Detection

* Gitleaks

## Infrastructure as Code Scanning

* Checkov

## Container Security

* Trivy

## Policy as Code

* Open Policy Agent (OPA)

If security policies fail, the deployment is blocked.

---

# Terraform Modules

The project is organized into reusable Terraform modules including:

* VPC
* Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* IAM
* KMS
* Secrets Manager
* Amazon ECR
* Amazon EKS
* EC2
* CloudWatch
* CloudTrail
* S3 Backend
* DynamoDB State Locking

---

# Deployment Steps

## Clone Repository

```bash
git clone https://github.com/<your-username>/Enterprise-Automated-Application-Security-Policy-Enforcement-Pipeline.git

cd Enterprise-Automated-Application-Security-Policy-Enforcement-Pipeline
```

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Generate Execution Plan

```bash
terraform plan
```

## Deploy Infrastructure

```bash
terraform apply
```

---

# Kubernetes Deployment

Deploy the application to Amazon EKS:

```bash
kubectl apply -f kubernetes/deployment.yaml

kubectl apply -f kubernetes/service.yaml
```

---

# CI/CD Security Workflow

```
Code Commit
      │
      ▼
GitHub Actions
      │
      ├── Semgrep
      ├── Gitleaks
      ├── Checkov
      ├── Trivy
      └── OPA Policy
              │
       Pass ─────── Fail
         │            │
         ▼            ▼
Terraform Apply   Pipeline Stops
         │
         ▼
Deploy to Amazon EKS
```

---

# Wazuh Integration

Security events generated by the pipeline can be forwarded to Wazuh SIEM for:

* Centralized security monitoring
* Security dashboards
* Threat detection
* Compliance reporting
* Incident response
* Security analytics

---

# Future Enhancements

* AWS Security Hub integration
* GuardDuty integration
* Inspector integration
* Lambda auto-remediation
* ArgoCD GitOps deployment
* Falco runtime container monitoring
* Prometheus and Grafana dashboards
* Multi-account AWS deployment
* Cross-account IAM roles

---

# Author

**Timothy Olubiyi**

Cloud Security | DevSecOps | AWS | Terraform | Kubernetes | SIEM Engineering

---

# License

This project is intended for educational, research, and enterprise DevSecOps implementation purposes.

