The complete enterprise-grade GitHub Actions DevSecOps pipeline that integrates:

🔎 Semgrep (SAST)
🔐 Gitleaks (Secrets detection)
🐳 Trivy (Container + filesystem scanning)
🏗 Checkov (IaC scanning)
🧠 OPA (Policy-as-Code enforcement)

# 📁 Location
.github/
└── workflows/
      └── devsecops-pipeline.yml

# 🧠 OPA Policy (Policy-as-Code)

opa/
├── policy.rego
└── input.json

# 🧭 Pipeline Flow

Developer Push
      │
      ▼
GitHub Actions
      │
      ├── Semgrep (SAST)
      ├── Gitleaks (Secrets)
      ├── Checkov (IaC)
      ├── Trivy FS Scan
      ├── Docker Build
      ├── Trivy Image Scan
      └── OPA Policy Gate
                │
        ┌───────┴────────┐
        ▼                ▼
     PASS              FAIL
        │                │
        ▼                ▼
   Deploy to EKS     Block Pipeline