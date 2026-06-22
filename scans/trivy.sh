# Filesystem Scan
trivy fs --format json \
  -o scans/trivy/fs-report.json .

# Container Scan
trivy image --format json \
  -o scans/trivy/image-report.json enterprise-app:latest

echo "Report generated at scans/reports/full-report.json"