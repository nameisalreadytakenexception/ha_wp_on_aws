output "db_subnet_group_id" {
  description = "db_subnet_group_id value"
  value       = aws_db_subnet_group.db-subnet-group.id
}
output "db_port" {
  description = "db_port value"
  value       = var.db_port
}