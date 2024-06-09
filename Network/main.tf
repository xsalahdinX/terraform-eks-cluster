/**
 * # Network.
 *
 * Network use to operate Eks.
 */


resource "aws_vpc" "EKS_VPC" {
  cidr_block           = var.vpc_cider
  enable_dns_hostnames = true
  tags                 = merge({ "Name" : "EKS_VPC" }, var.my_tags)
}

#we use for_each to loop over the list of private ciders and then we use the each.key to refer to them 
#toset() function is used to convert a list to a set insure unique values
#tolist() function is used to convert a set to a list order to access the elements by index
# % is the modulo operator, which ensures that the index stays within the bounds of the availability zones list. If the index exceeds the length of the availability zones list, it wraps around to the beginning.

resource "aws_subnet" "private_subnets" {
  for_each          = toset(var.private_ciders)
  vpc_id            = aws_vpc.EKS_VPC.id
  availability_zone = element(var.az, index(tolist(toset(var.private_ciders)), each.key) % length(var.az))
  cidr_block        = each.key
  tags              = merge({ "kubernetes.io/role/internal-elb" : "1" , "Name" : "private_subnets_${index(tolist(toset(var.private_ciders)), each.key)}" }, var.my_tags)
}

resource "aws_subnet" "public_subnets" {
  for_each          = toset(var.public_ciders)
  vpc_id            = aws_vpc.EKS_VPC.id
  availability_zone = element(var.az, index(tolist(toset(var.public_ciders)), each.key) % length(var.az))
  cidr_block        = each.key
  tags              = merge({ "kubernetes.io/role/elb" : "1", "Name" : "public_subnets_${index(tolist(toset(var.public_ciders)), each.key)}" }, var.my_tags)

}

resource "aws_internet_gateway" "EKS_internet_gateway" {
  vpc_id = aws_vpc.EKS_VPC.id
  tags   = merge({ "Name" : "EKS_internet_gateway" }, var.my_tags)
}

# resource "aws_eip" "eip" {
#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.EKS_internet_gateway]
#   tags       = merge({ "Name" : "EKS_eip" }, var.my_tags)
#   count = length(var.public_ciders)
# }


# NAT Gateway configuration
# resource "aws_nat_gateway" "EKS_Nat_gateway" {
#   for_each = aws_subnet.public_subnets
#   allocation_id = aws_eip.eip[index(keys(aws_subnet.public_subnets), each.key)].id
#   subnet_id     = each.value.id
#   tags          = merge({ "Name" : "EKS_Nat_gateway" }, var.my_tags)
#   depends_on    = [aws_eip.eip]
# }



resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.EKS_internet_gateway]
  tags       = merge({ "Name" : "EKS_eip" }, var.my_tags)
  count = var.nat_gateways_count
}

resource "aws_nat_gateway" "EKS_Nat_gateway" {
  count = var.nat_gateways_count
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = values(aws_subnet.public_subnets)[count.index].id
  tags          = merge({ "Name" : "EKS_Nat_gateway" }, var.my_tags)
  depends_on    = [aws_eip.eip]
}




resource "aws_route_table" "private_route_table" {
  vpc_id  = aws_vpc.EKS_VPC.id
  for_each = { for idx, nat_gw in aws_nat_gateway.EKS_Nat_gateway : nat_gw.id => nat_gw }

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = each.value.id
  }

  tags       = merge({ "Name" : "EKS_private_route_table" }, var.my_tags)
  depends_on = [aws_internet_gateway.EKS_internet_gateway]
}



resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.EKS_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EKS_internet_gateway.id
  }
  tags = merge({ "Name" : "EKS_public_route_table" }, var.my_tags)

  depends_on = [aws_nat_gateway.EKS_Nat_gateway]
}



resource "aws_route_table_association" "private_route_table_association" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id 
  route_table_id = aws_route_table.private_route_table[index(keys(aws_subnet.private_subnets), each.key) % var.nat_gateways_count].id
}

resource "aws_route_table_association" "public_route_table_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

output "private_subnets_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}
