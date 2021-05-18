resource "tls_private_key" "ha-wp-private-key" {
  algorithm = "RSA"
  rsa_bits  = 8192
}
resource "aws_key_pair" "ha-wp-public-key" {
  key_name   = var.key_name
  public_key = tls_private_key.ha-wp-private-key.public_key_openssh
}
resource "null_resource" "ha-wp-key-pair" {
  provisioner "local-exec" {
    command = "echo  ${tls_private_key.ha-wp-private-key.private_key_pem} >> ha_wp_private_key.pem"
  }
}