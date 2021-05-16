output "db_port" {
  description = "db_port value"
  value       = var.db_port
}
output "db_sg_id" {
  description = "db_sg value"
  value       = aws_security_group.ha-wp-sg-db.id
}
output "private_subnets_sg_id" {
  description = "private_subnets_sg_id value"
  value       = aws_security_group.ha-wp-sg-exec-node.id
}