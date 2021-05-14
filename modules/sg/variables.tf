variable "vpc_id" {
  type        = string
  description = "var for vpc_id"
}
variable "db_port" {
  type        = string
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


# variable "server_port" {
#   description = "the port the web server will be listening"
#   type        = number
#   default     = 8080
# }
# variable "lb_port" {
#   description = "the port the elb will be listening"
#   type        = number
#   default     = 80
# }