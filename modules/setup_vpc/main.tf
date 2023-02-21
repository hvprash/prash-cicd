## Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.app_name}-vpc"
  }
}

## Create Internet Gateway
resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.app_name}-igw"
  }

}

## Create Public Subnet
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}-public-subnet-${count.index + 1}"
  }
}

## Create public RTB
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app_name}-rtb-public"
  }
}

## Create route
resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_igw.id
}

## Associate subnets to public route table 
resource "aws_route_table_association" "associate_public_rtb" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.rtb_public.id
}