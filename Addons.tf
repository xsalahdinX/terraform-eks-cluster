module "Addons" {
  source = "github.com/xsalahdinX/terraform-modules//Addons"
  cluster_version = "1.28"
  cluster_name = module.EKS.cluster_name
  depends_on = [module.node_group]
  }