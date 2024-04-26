resource "aws_eks_addon" "vpc_cni" {

  addon_name                  = "vpc-cni"
  addon_version               = "v1.18.0-eksbuild.1"
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "PRESERVE"
  tags                        = merge({ "eks_addon" = "vpccni" }, var.my_tags)

}

resource "aws_eks_addon" "kube_proxy" {
  addon_name                  = "kube-proxy"
  addon_version               = "v1.28.6-eksbuild.2"
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "PRESERVE"
  tags                        = merge({ "eks_addon" = "kubeproxy" }, var.my_tags)

}

resource "aws_eks_addon" "core_dns" {

  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.7"
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "PRESERVE"
  tags                        = merge({ "eks_addon" = "coredns" }, var.my_tags)
}
