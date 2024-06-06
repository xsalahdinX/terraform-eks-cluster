data "aws_eks_addon_version" "vpc_cni_addon" {
  addon_name         = "vpc-cni"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "kube_proxy_addon" {
  addon_name         = "kube-proxy"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "coredns_addon" {
  addon_name         = "coredns"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "s3_csi_driver_addon" {
  addon_name         = "aws-mountpoint-s3-csi-driver"
  kubernetes_version = var.cluster_version
}