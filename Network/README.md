<!-- BEGIN_TF_DOCS -->

# Network.

Network use to operate Eks.

##  Modules
Network Module
```hcl
module "EKS_Network" {
  source         = "./Network"
  vpc_cider      = "10.0.0.0/16"
  private_ciders = ["10.0.1.0/24", "10.0.2.0/24"]
  public_ciders  = ["10.0.3.0/24", "10.0.4.0/24"]
  my_tags        = { "Owned" : "Salahdin&Gamil"}
  az             = ["us-east-1a", "us-east-1b"]
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Resources

| Name | Type |
|------|------|
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.EKS_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.EKS_Nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.EKS_VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | value of availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_my_tags"></a> [my\_tags](#input\_my\_tags) | tags for Eks resources | `map(string)` | <pre>{<br>  "Owned": "Salahdin"<br>}</pre> | no |
| <a name="input_private_ciders"></a> [private\_ciders](#input\_private\_ciders) | private subnets ciders | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_public_ciders"></a> [public\_ciders](#input\_public\_ciders) | public subnets ciders | `list(string)` | <pre>[<br>  "10.0.3.0/24",<br>  "10.0.4.0/24"<br>]</pre> | no |
| <a name="input_vpc_cider"></a> [vpc\_cider](#input\_vpc\_cider) | VPC CIDERS | `string` | `"10.0.0.0/16"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | n/a |
<!-- END_TF_DOCS -->