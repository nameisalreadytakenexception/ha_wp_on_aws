output "vpc_id" {
  description = "vpc_id value"
  value       = aws_vpc.ha-wp-vpc.id
}
output "eip_id" {
  description = "eip_id values"
  value       = ["${aws_eip.ha-wp-eip.*.id}"]
}
output "subnet_public_id" {
  description = "subnet_public_id values"
  value       = ["${aws_subnet.ha-wp-subnet-public.*.id}"]
}
output "subnet_private_id" {
  description = "subnet_privatr_id values"
  value       = aws_subnet.ha-wp-subnet-private.*.id
}
output "db_subnet_id" {
  description = "db_subnet_id values"
  value       = aws_subnet.db-subnet.*.id
}
output "cidr_block_db_subnet" {
  description = "cidr_block_db_subnet values"
  value       = var.cidr_block_db_subnet
}
output "cidr_block_subnet_private" {
  description = "cidr_block_subnet_private values"
  value       = var.cidr_block_subnet_private
}
output "cidr_block_subnet_public" {
  description = "cidr_block_subnet_public values"
  value       = var.cidr_block_subnet_public
}
output "azs" {
  description = "azs values"
  value       = var.azs
}