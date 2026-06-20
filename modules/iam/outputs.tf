############################################
# GitHub Actions OIDC Role
############################################

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

############################################
# EC2 Role Outputs
############################################

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}

############################################
# (OPTIONAL BUT REQUIRED FOR YOUR EKS ERROR)
# If you want IAM-managed EKS role here
############################################

output "eks_cluster_role_arn" {
  value = aws_iam_role.ec2_role.arn
}