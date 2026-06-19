###########################################
# Amazon ECR Repository
###########################################

resource "aws_ecr_repository" "repository" {

  name = var.repository_name

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {

    Name        = var.repository_name
    Environment = var.environment
    ManagedBy   = "Terraform"

  }

}

###########################################
# Lifecycle Policy
###########################################

resource "aws_ecr_lifecycle_policy" "policy" {

  repository = aws_ecr_repository.repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 20 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF

}