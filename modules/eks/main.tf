#############################################
# IAM Role for EKS Cluster
#############################################

resource "aws_iam_role" "eks_cluster" {

  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "eks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false  # CKV_AWS_39: Disable public endpoint
    public_access_cidrs     = []     # CKV_AWS_38: Restrict access
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]  # CKV_AWS_37: Enable all log types

  encryption_config {
    provider {
      key_arn = var.kms_key_arn
    }
    resources = ["secrets"]  # CKV_AWS_58: Enable secrets encryption
  }

  depends_on = [aws_iam_role_policy_attachment.cluster_policy]
}


resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role = aws_iam_role.eks_cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

#############################################
# IAM Role for Worker Nodes
#############################################

resource "aws_iam_role" "eks_node" {

  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "worker1" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}

resource "aws_iam_role_policy_attachment" "worker2" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

resource "aws_iam_role_policy_attachment" "worker3" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}

#############################################
# EKS Cluster
#############################################



#############################################
# Managed Node Group
#############################################

resource "aws_eks_node_group" "nodes" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "managed-workers"

  node_role_arn = aws_iam_role.eks_node.arn

  subnet_ids = var.subnet_ids

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  capacity_type = "ON_DEMAND"
}


