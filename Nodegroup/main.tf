resource "aws_eks_node_group" "eks_node_group" {
  node_group_name = var.node_group_name
  cluster_name    = var.cluster_name
  node_role_arn   = aws_iam_role.node_group_iam_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_type]
  ami_type        = var.ami_type
  capacity_type   = "ON_DEMAND"
  disk_size       = 20

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  
  update_config {
    max_unavailable = 1
  }
  tags   = merge({ "Name" : "aws_eks_node_group" }, var.my_tags)
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cni-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.container-AmazonEC2ContainerRegistryReadOnly,
  ]
}