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

  depends_on = [
    aws_iam_role_policy_attachment.EKS_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.EKS_AmazonEKSVPCResourceController,
  ]
}

resource "aws_iam_openid_connect_provider" "eks-cluster-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.EKS_cert.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.EKS_cert.url
}

