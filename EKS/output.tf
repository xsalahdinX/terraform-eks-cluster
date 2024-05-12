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