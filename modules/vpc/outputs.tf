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
output "db_subnet_id" {
  description = "db_subnet_id values"
  value       = "${aws_subnet.db-subnet.*.id}"
}
# output "subnet_private_id" {
#   description = "subnet_private_id value"
#   value       = aws_subnet.ha-wp-subnet-private.id
# }
# output "internet_gateway_id" {
#   description = "internet_gateway_id value"
#   value       = aws_internet_gateway.ha-wp-internet-gateway.id
# }
# output "nat_gateway_id" {
#   description = "nat_gateway_id value"
#   value       = aws_nat_gateway.ha-wp-nat-gateway.id
# }
# output "route_table_private_id" {
#   description = "route_table_private_id value"
#   value       = aws_route_table.ha-wp-route-table-private.id
# }
# output "route_table_public_id" {
#   description = "route_table_public_id value"
#   value       = aws_route_table.ha-wp-route-table-public.id
# }
# output "security_group_id" {
#   description = "security_group_id value"
#   value       = aws_security_group.ha-wp-security-group.id
# }