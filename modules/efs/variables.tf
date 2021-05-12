variable "creation_token" {
  default     = "ha-wp-token"
  description = "efs creation token"
  type        = string
}
variable "encrypted_efs" {
  default     = false
  description = "encrypted efs"
  type        = bool
}