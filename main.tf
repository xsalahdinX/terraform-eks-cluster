module "EKS_Network" {
  source         = "./Network"
  region         = var.region
  access_key     = var.access_key
  secret_key     = var.secret_key
  vpc_cider      = "10.0.0.0/16"
  private_ciders = ["10.0.1.0/24", "10.0.2.0/24"]
  public_ciders  = ["10.0.3.0/24", "10.0.4.0/24"]
  my_tags        = { "Owned" : "Salahdin&Gamil"}
  az             = ["us-east-1a", "us-east-1b"]

}

module "EKS" {
    source = "./EKS"
    cluster_name = "eks_cluster"
    cluster_version = "1.28"
    subnet_ids = module.EKS_Network.private_subnets_ids
    depends_on = [ module.EKS_Network ]
}




module "node_group" {
  source          = "./Nodegroup"
  cluster_name    = module.EKS.cluster_name
  node_group_name = "eks_node_group"
  subnet_ids      = module.EKS_Network.private_subnets_ids
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  depends_on      = [module.EKS]
  instance_type   = "t3.medium"
  ami_type        = "AL2_x86_64"
  my_tags        = { "Owned" : "SalahdinandGamil"}
}




module "Addons" {
  source = "./Addons"
  cluster_name = module.EKS.cluster_name
  my_tags = { "Owned" : "SalahdinandGamil"}
  depends_on = [module.EKS]
  }

module "cluser_role" {
  source = "./user_roles"
  cluster_arn = module.EKS.cluster_arn
  username = "gamil"
  depends_on = [module.EKS]  
}

module "aws_auth" {
  source = "./aws-auth"
  cluster_name = module.EKS.cluster_name
  cluster_ca_certificate = module.EKS.kubeconfig-certificate-authority-data
  host = module.EKS.endpoint
  depends_on = [ module.cluser_role ]
}