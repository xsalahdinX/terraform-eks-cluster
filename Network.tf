module "EKS_Network" {
  source         = "github.com/xsalahdinX/terraform-modules//Network"
  vpc_cider      = "10.0.0.0/16"
  private_ciders = ["10.0.1.0/24", "10.0.2.0/24"]
  public_ciders  = ["10.0.3.0/24", "10.0.4.0/24"]
  my_tags        = { "Owned" : "Salahdin&Gamil"}
  az             = ["us-east-1a", "us-east-1b"]
  nat_gateways_count = 2
}