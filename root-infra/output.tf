output "vpc_id" {

  description = "VPC ID"

  value = module.vpc.vpc_id

}

output "public_subnet_id" {

  description = "Public Subnet"

  value = module.subnet.public_subnet

}

output "private_subnet1_id" {

  description = "Private Subnet 1"

  value = module.subnet.private_subnet1

}

output "private_subnet2_id" {

  description = "Private Subnet 2"

  value = module.subnet.private_subnet2

}

output "internet_gateway_id" {

  value = module.igw.igw_id

}

output "nat_gateway_id" {

  value = module.nat.nat_id

}

output "security_group_id" {

  value = module.securitygroup.security_group_id

}

output "github_oidc_role" {

  value = module.iam.github_role_arn

}

output "secret_arn" {

  value = module.secretsmanager.secret_arn

}

output "ecr_repository_url" {

  value = module.ecr.repository_url

}

output "ecr_repository_name" {

  value = module.ecr.repository_name

}

output "eks_cluster_name" {

  value = module.eks.cluster_name

}

output "eks_endpoint" {

  value = module.eks.cluster_endpoint

}

output "wazuh_private_ip" {

  value = module.ec2.private_ip

}

output "wazuh_instance_id" {

  value = module.ec2.instance_id

}

output "cloudwatch_log_group" {

  value = module.cloudwatch.log_group_name

}


output "vpc_flow_log_id" {

  value = module.vpc.flow_log_id

}