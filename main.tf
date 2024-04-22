module "EKS_Network" {
  source         = "./Network"
  region         = var.region
  access_key     = var.access_key
  secret_key     = var.secret_key
  vpc_cider      = "10.0.0.0/16"
  private_ciders = ["10.0.1.0/24", "10.0.2.0/24"]
  public_ciders  = ["10.0.3.0/24", "10.0.4.0/24"]
  my_tags        = { "Name" : "EKS Resource", "Owned" : "Salahdin" }
  az             = ["us-east-1a", "us-east-1b"]

}

module "EKS" {
    source = "./EKS"
    cluster_name = "eks_cluster"
    cluster_version = "1.28"
    subnet_ids = module.EKS_Network.private_subnets_ids
    depends_on = [ module.EKS_Network ]
}