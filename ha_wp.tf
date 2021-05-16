terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source                    = "./modules/vpc"
  vpc_id                    = module.vpc.vpc_id
  cidr_block_vpc            = "10.0.0.0/16"
  cidr_block_subnet_public  = ["10.0.1.0/24", "10.0.2.0/24"]
  cidr_block_subnet_private = ["10.0.3.0/24", "10.0.4.0/24"]
  cidr_block_db_subnet      = ["10.0.5.0/24", "10.0.6.0/24"]
}
module "sg" {
  source                    = "./modules/sg"
  vpc_id                    = module.vpc.vpc_id
  db_port                   = 3306
  cidr_block_db_subnet      = module.vpc.cidr_block_db_subnet
  cidr_block_subnet_private = module.vpc.cidr_block_subnet_private
  cidr_block_subnet_public  = module.vpc.cidr_block_subnet_public
}
module "db" {
  source                 = "./modules/db"
  subnet_ids             = module.vpc.db_subnet_id
  db_port                = module.sg.db_port
  vpc_security_group_ids = [module.sg.db_sg_id]
  # multi_az               = true          # in case of multi-az
  # instance_class         = "db.t3.micro" # in case of multi-az
}
module "efs" {
  source        = "./modules/efs"
  encrypted_efs = true
}
