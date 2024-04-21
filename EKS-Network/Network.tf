resource "aws_vpc" "EKS_VPC" {

  cidr_block           = var.vpc_cider
  enable_dns_hostnames = true
  tags                 = var.my_tags
}




resource "aws_subnet" "private_subnets" {
  for_each          = toset(var.private_ciders)
  vpc_id            = aws_vpc.EKS_VPC.id
  availability_zone = element(var.az, length(var.private_ciders) % length(var.az))
  cidr_block        = each.key
  tags              = var.my_tags
}


resource "aws_subnet" "public_subnets" {
  for_each          = toset(var.public_ciders)
  vpc_id            = aws_vpc.EKS_VPC.id
  availability_zone = element(var.az, length(var.public_ciders) % length(var.az))
  cidr_block        = each.key
  tags              = var.my_tags

}

resource "aws_internet_gateway" "EKS_internet_gateway" {

  vpc_id = aws_vpc.EKS_VPC.id
  tags   = var.my_tags
}


resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.EKS_internet_gateway]
}


resource "aws_nat_gateway" "EKS_Nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = element(aws_subnet.public_subnets[*].id, 0)
  tags          = var.my_tags
  depends_on    = [aws_eip.eip]
}



resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.EKS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EKS_internet_gateway.id
  }
  tags       = var.my_tags
  depends_on = [aws_internet_gateway.EKS_internet_gateway]
}



resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.EKS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EKS_internet_gateway.id
  }
  tags       = var.my_tags
  depends_on = [aws_nat_gateway.EKS_Nat_gateway]
}




resource "aws_route_table_association" "private_route_table_association" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_route_table_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}





