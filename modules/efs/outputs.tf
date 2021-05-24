output "mount_target_dns" {
  description = "address of the mount target provisioned."
  value       = aws_efs_mount_target.ha-wp-efs-mount-target.0.dns_name
}