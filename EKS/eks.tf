resource "aws_eks_cluster" "Eks_Cluster" {
  name     = var.cluster_name
  version = var.cluster_version
  role_arn = aws_iam_role.EKS_role.arn

  vpc_config {
    # subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

#   Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.EKS_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.EKS_AmazonEKSVPCResourceController,
  ]
}


output "endpoint" {
  value = aws_eks_cluster.Eks_Cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.Eks_Cluster.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.Eks_Cluster.name
  
}

output "cluster_arn" {
  value = aws_eks_cluster.Eks_Cluster.arn 
}