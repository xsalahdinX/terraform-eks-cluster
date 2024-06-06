module "cluser_role" {
  source = "./user_roles"
  cluster_arn = module.EKS.cluster_arn
  username = "gamil"
  depends_on = [module.EKS]  
}