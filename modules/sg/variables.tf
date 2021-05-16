variable "vpc_id" {
  type        = string
  description = "var for vpc_id"
}
variable "db_port" {
  type        = string
  default     = 3306
  description = "var for db_port"
}
variable "cidr_block_subnet_public" {
  description = "cidr block for public subnets"
  type        = list(string)
}
variable "cidr_block_subnet_private" {
  description = "cidr block for private subnets"
  type        = list(string)
}
variable "cidr_block_db_subnet" {
  description = "cidr block for db subnets"
  type        = list(string)
}
variable "exec_node_port" {
  description = "var for exec_node_port"
  type        = number
  default     = 8080
}
variable "lb_port" {
  description = "var for lb_port"
  type        = number
  default     = 80
}