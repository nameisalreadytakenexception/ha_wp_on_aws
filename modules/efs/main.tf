resource "aws_efs_file_system" "ha-wp-efs-file-system" {
  creation_token = var.creation_token
  encrypted      = var.encrypted_efs
  tags           = { Name = "ha-wp-efs" }
}