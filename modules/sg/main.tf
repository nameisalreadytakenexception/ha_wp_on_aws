# DB security group
resource "aws_security_group" "ha-wp-sg-db" {
  name        = "sg_db"
  description = "security group for db"
  vpc_id      = var.vpc_id
  ingress {
    description = "from exec_nodes to db"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_private
  }
  egress {
    description = "from db to exec_nodes"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # var.cidr_block_db_subnet
  }
  tags = { Name = "sg-db" }
}

# EXEC_NODES security group
resource "aws_security_group" "ha-wp-sg-exec-node" {
  name        = "sg_exec_node"
  description = "security group for exec_nodes"
  vpc_id      = var.vpc_id
  ingress {
    description = "from lb to exec_nodes"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_public
  }
  ingress {
    description = "EFS mount target"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_private
  }
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_private # ["0.0.0.0/0"]
  }
  egress {
    description = "from exec_nodes to lb"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # var.cidr_block_subnet_public
  }

  egress {
    description = "EFS mount target"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # var.cidr_block_subnet_private
  }
  tags = { Name = "sg-exec-node" }
}

# LB security group
resource "aws_security_group" "ha-wp-sg-lb" {
  name        = "sg_lb"
  description = "security group for lb"
  vpc_id      = var.vpc_id
  ingress {
    description = "from world & nodes to lb"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "from lb to world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "sg-lb" }
}