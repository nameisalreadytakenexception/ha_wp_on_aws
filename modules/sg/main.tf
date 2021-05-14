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