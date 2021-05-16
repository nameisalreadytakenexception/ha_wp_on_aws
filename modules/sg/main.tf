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
    cidr_blocks = var.cidr_block_db_subnet
  }
  tags = { Name = "sg-db" }
}

# EXEC_NODES security group
resource "aws_security_group" "ha-wp-sg-exec-node" {
  name        = "sg_exec_node"
  description = "security group for exec_nodes"
  vpc_id      = var.vpc_id
  ingress {
    description = "from exec_nodes to lb"
    from_port   = var.exec_node_port
    to_port     = var.exec_node_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_private
  }
  egress {
    description = "from lb to exec_nodes"
    from_port   = var.exec_node_port
    to_port     = var.exec_node_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_public
  }
  tags = { Name = "sg-exec-node" }
}

# LB security group
resource "aws_security_group" "ha-wp-sg-lb" {
  name        = "sg_lb"
  description = "security group for lb"
  vpc_id      = var.vpc_id
  ingress {
    description = "from world to lb"
    from_port   = var.lb_port
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "from lb to world"
    from_port   = var.lb_port
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_subnet_public
  }
  tags = { Name = "sg-lb" }
}