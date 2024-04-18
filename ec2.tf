
#count,if,list,map

resource "aws_instance" "test" {

  ami           = var.env == "prod" ? var.imgae_kind[count.index] : var.imgae_kind[0]
  instance_type = var.env == "prod" ? var.ec2_type.prod : var.ec2_type.preprod
  subnet_id     = aws_subnet.private_subnet.id
  tags          = var.my_tags
  count         = var.env == "prod" ? 2 : 1
}


#lookup,map,elemnt

resource "aws_instance" "test2" {

  #   ami           = var.imgae_kind[count.index]
  ami           = element(var.imgae_kind, count.index)
  instance_type = local.ec2_type
  subnet_id     = aws_subnet.private_subnet.id
  tags          = var.my_tags
  count         = 2

}




