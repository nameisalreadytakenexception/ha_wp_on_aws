resource "aws_efs_file_system" "ha-wp-efs-file-system" {
  creation_token = var.creation_token
  encrypted      = var.encrypted_efs
  tags           = { Name = "ha-wp-efs" }
}
resource "aws_efs_mount_target" "ha-wp-efs-mount-target" {
  file_system_id  = aws_efs_file_system.ha-wp-efs-file-system.id
  count           = length(var.azs)
  subnet_id       = element(var.subnet_ids, count.index)
  security_groups = var.security_groups
}