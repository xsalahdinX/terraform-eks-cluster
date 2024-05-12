data "tls_certificate" "EKS_cert" {
  url = aws_eks_cluster.Eks_Cluster.identity[0].oidc[0].issuer
}