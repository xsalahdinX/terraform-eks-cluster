provider "helm" {
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name ,"--role-arn", "arn:aws:iam::211125357951:role/eks_access_role"]
      command     = "aws"
    }
  }
}
