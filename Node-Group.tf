module "node_group" {
  source          = "./Nodegroup"
  cluster_name    = module.EKS.cluster_name
  node_group_name = "eksnodegroup"
  subnet_ids      = module.EKS_Network.private_subnets_ids
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  instance_type   = "t3.medium"
  ami_type        = "AL2_x86_64"
  my_tags        = { "Owned" : "Salahdin"}
  depends_on      = [module.EKS]

}