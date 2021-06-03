output "db_subnet_group_id" {
  description = "db_subnet_group_id value"
  value       = aws_db_subnet_group.db-subnet-group.id
}
output "db_host" {
  description = "db_host value"
  value       = aws_db_instance.ha-wp-db-instance.endpoint
}
output "db_name" {
  description = "db_name value"
  value       = var.db_name
}
output "db_username" {
  description = "db_username value"
  value       = var.db_username
}
output "db_password" {
  description = "db_password value"
  value       = var.db_password
}