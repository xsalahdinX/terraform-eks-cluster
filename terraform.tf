module "EKS_Network" {
  source         = "./EKS-Network"
  region         = var.region
  access_key     = var.access_key
  secret_key     = var.secret_key
  vpc_cider      = "10.0.0.0/16"
  private_ciders = ["10.0.1.0/24", "10.0.2.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  public_ciders  = ["10.0.3.0/24", "10.0.4.0/24"]
  my_tags        = { "Owned" : "Salahdin" }
  az             = ["us-east-1a", "us-east-1b", "us-east-1c"]

}