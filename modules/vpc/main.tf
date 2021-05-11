resource "aws_vpc" "ha-wp" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}
resource "aws_internet_gateway" "ha-wp-internet-gateway" {
  vpc_id = var.vpc_id
  tags   = { Name = "ha-wp-internet-gateway" }
}
resource "aws_subnet" "ha-wp-subnet-public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_subnet_public
  map_public_ip_on_launch = true
  availability_zone       = var.azs
  tags                    = { Name = "ha-wp-subnet-public" }
  depends_on              = [aws_internet_gateway.ha-wp-internet-gateway]
}
resource "aws_subnet" "ha-wp-subnet-private" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_subnet_private
  availability_zone       = var.azs
  tags                    = { Name = "ha-wp-subnet-private" }
}
resource "aws_subnet" "db-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_db_subnet
  availability_zone       = var.azs
  tags                    = { Name = "db-subnet" }
}
resource "aws_eip" "ha-wp-eip" {
#   public_ipv4_pool = "amazon"
  vpc              = true
  tags             = { Name = "ha-wp-eip" }
  depends_on       = [aws_internet_gateway.ha-wp-internet-gateway]
}
resource "aws_nat_gateway" "ha-wp-nat-gateway" {
  allocation_id = aws_eip.ha-wp-eip.id
  subnet_id     = aws_subnet.ha-wp-subnet-public.id
  tags          = { Name = "ha-wp-nat-gateway" }
  depends_on    = [aws_eip.ha-wp-eip]
}