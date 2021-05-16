variable "allocated_storage" {
  default     = 10
  description = "allocated storage"
  type        = number
}
variable "engine" {
  default     = "mysql"
  description = "db engine"
  type        = string
}
variable "engine_version" {
  default     = "8.0.20"
  description = "db engine version"
  type        = string
}
variable "instance_class" {
  default     = "db.t2.micro"
  description = "db instance class"
  type        = string
}
variable "db_name" {
  default     = "wp_db"
  description = "db name"
  type        = string
}
variable "db_username" {
  default     = "wp_user"
  description = "db username"
  type        = string
}
variable "db_password" {
  default     = "wp_password"
  description = "db password"
  type        = string
}
variable "db_port" {
  default     = 3306
  description = "db port"
  type        = number
}
variable "subnet_ids" {
  description = "subnet ids"
  type        = list(any)
}
variable "storage_type" {
  default     = "gp2"
  description = "storage type"
  type        = string
}
variable "backup_retention_period" {
  default     = 3
  description = "backup retention period (days)"
  type        = number
}
variable "multi_az" {
  default     = false
  description = "enabling multi_az"
  type        = bool
}
variable "vpc_security_group_ids" {
  description = "sg for db"
  type        = list(any)
}