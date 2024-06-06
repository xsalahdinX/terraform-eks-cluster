resource "aws_eks_addon" "vpc_cni" {

  addon_name                  = "vpc-cni"
  addon_version               = data.aws_eks_addon_version.vpc_cni_addon.version
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "OVERWRITE"

}

resource "aws_eks_addon" "kube_proxy" {
  addon_name                  = "kube-proxy"
  addon_version               = data.aws_eks_addon_version.kube_proxy_addon.version
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "OVERWRITE"

}

resource "aws_eks_addon" "core_dns" {

  addon_name                  = "coredns"
  addon_version               = data.aws_eks_addon_version.coredns_addon.version
  cluster_name                = var.cluster_name
  resolve_conflicts_on_update = "OVERWRITE"
}
