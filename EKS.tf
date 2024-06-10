module "EKS" {
    source = "github.com/xsalahdinX/terraform-modules//EKS"
    cluster_name = "eks"
    cluster_version = "1.28"
    subnet_ids = module.EKS_Network.private_subnets_ids
    depends_on = [ module.EKS_Network ]
}