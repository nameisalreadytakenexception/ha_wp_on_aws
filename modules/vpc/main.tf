#VPC
resource "aws_vpc" "ha-wp-vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

# IGW
resource "aws_internet_gateway" "ha-wp-internet-gateway" {
  vpc_id = var.vpc_id
  tags   = { Name = "ha-wp-internet-gateway" }
}

# SUBNETS
resource "aws_subnet" "ha-wp-subnet-public" {
  vpc_id                  = var.vpc_id
  count                   = length(var.azs)
  cidr_block              = element(var.cidr_block_subnet_public, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs , count.index)
  tags                    = { Name = "ha-wp-subnet-public-${count.index+1}" }
  depends_on              = [aws_internet_gateway.ha-wp-internet-gateway]
}
resource "aws_subnet" "ha-wp-subnet-private" {
  vpc_id                  = var.vpc_id
  count                   = length(var.azs)
  cidr_block              = element(var.cidr_block_subnet_private, count.index)
  availability_zone       = element(var.azs , count.index)
  tags                    = { Name = "ha-wp-subnet-private-${count.index+1}" }
}
resource "aws_subnet" "db-subnet" {
  vpc_id                  = var.vpc_id
  count                   = length(var.azs)
  cidr_block              = element(var.cidr_block_db_subnet, count.index)
  availability_zone       = element(var.azs , count.index)
  tags                    = { Name = "db-subnet-${count.index+1}" }
}

#ROUTES

# EIP
resource "aws_eip" "ha-wp-eip" {
#   public_ipv4_pool = "amazon"
  vpc              = true
  count            = length(var.azs)
  tags             = { Name = "ha-wp-eip-${count.index+1}" }
  depends_on       = [aws_internet_gateway.ha-wp-internet-gateway]
}

# NAT gateway
resource "aws_nat_gateway" "ha-wp-nat-gateway" {
  count         = length(var.azs)
  allocation_id = element(aws_eip.ha-wp-eip.*.id , count.index)
  subnet_id     = element(aws_subnet.ha-wp-subnet-public.*.id , count.index)
  tags          = { Name = "ha-wp-nat-gateway-${count.index+1}" }
  depends_on    = [aws_eip.ha-wp-eip]
}