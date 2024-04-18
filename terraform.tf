resource "aws_vpc" "terra" {

  cidr_block = var.ciders.vpc_cider
  tags       = var.my_tags
}


resource "aws_internet_gateway" "terra_internet_gateway" {

  vpc_id = aws_vpc.terra.id
  tags   = var.my_tags
}
resource "aws_subnet" "public_subnet" {

  vpc_id     = aws_vpc.terra.id
  cidr_block = var.ciders.public_cider
  tags       = var.my_tags
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.terra.id
  route {
    cidr_block = var.ciders.private_cider
    gateway_id = aws_internet_gateway.terra_internet_gateway.id
  }
  tags = var.my_tags
}

resource "aws_route_table_association" "public_asociation" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {

  vpc_id     = aws_vpc.terra.id
  cidr_block = var.ciders.private_cider
  tags       = var.my_tags
}


resource "aws_route_table" "private_route_table" {

  vpc_id = aws_vpc.terra.id
  route  = []
  tags   = var.salahdin
}


resource "aws_route_table_association" "private_asociation" {

  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
