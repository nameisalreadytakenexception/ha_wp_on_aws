resource "tls_private_key" "ha-wp-private-key" {
  algorithm = "RSA"
  rsa_bits  = 8192
}
resource "aws_key_pair" "ha-wp-public-key" {
  key_name   = var.key_name
  public_key = tls_private_key.ha-wp-private-key.public_key_openssh
}
resource "local_file" "ha-wp-key-pair" {
  content         = tls_private_key.ha-wp-private-key.private_key_pem
  filename        = "local_ha_wp_private_key.pem"
  file_permission = "0600"
}