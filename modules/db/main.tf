resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "ha-wp-db-subnet-group"
  subnet_ids = [var.subnet_ids[0], var.subnet_ids[1]]
  tags       = { Name = "db-subnet-group" }
}
resource "aws_db_instance" "default" {
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = var.db_port
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.db-subnet-group.id
  storage_type            = var.storage_type
  backup_retention_period = var.backup_retention_period
  multi_az                = var.multi_az
  depends_on              = [aws_db_subnet_group.db-subnet-group]
}