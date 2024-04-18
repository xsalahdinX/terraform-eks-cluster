locals {
  ec2_type = lookup(var.ec2_type, var.my_tags.env)
}
