output "ha-wp-private-key" {
  description = "ha-wp-private-key value"
  value       = tls_private_key.ha-wp-private-key.private_key_pem
}
output "ha-wp-public-key" {
  description = "ha-wp-public-key value"
  value       = tls_private_key.ha-wp-private-key.public_key_openssh
}
output "key_name" {
  description = "key_name value"
  value       = var.key_name
}