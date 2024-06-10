module "cluser_role" {
  source = "./user_roles"
  cluster_arn = module.EKS.cluster_arn
  username = "Salahdin"
  depends_on = [module.EKS]  
}