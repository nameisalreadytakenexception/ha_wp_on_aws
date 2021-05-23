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
variable "subnet_ids" {
  description = "list of subnet ids"
  type        = list(any)
}
variable "azs" {
  description = "availability zones"
  type        = list(string)
}
variable "security_groups" {
  description = "security groups zones"
  type        = list(string)
}