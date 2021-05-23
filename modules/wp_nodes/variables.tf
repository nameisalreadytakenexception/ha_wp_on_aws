variable "node_instance_type" {
  default     = "t2.micro"
  description = "instance type"
  type        = string
}
variable "node_count_max_size" {
  default     = 4
  description = "possible max node count"
  type        = number
}
variable "node_count_min_size" {
  default     = 2
  description = "min node count"
  type        = number
}
variable "security_groups" {
  description = "security groups"
  type        = list(any)
}
variable "vpc_zone_identifier" {
  description = "list of subnets for exec_nodes"
  type        = list(any)
}
variable "key_name" {
  description = "key_name value"
  type        = string
}
# variable "private_key" {
#   description = "private_key value"
#   type        = string
# }