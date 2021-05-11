variable "cidr_block_vpc" {
  default     = "10.0.0.0/16"
  description = "cidr block for vpc"
  type        = string
}
variable "tags" {
  description = "terraform-tag"
  default     = { terraform = "true", Name = "ha-wp" }
}
variable "cidr_block_subnet_public" {
  default     = "10.0.1.0/24"
  description = "cidr block for public subnet"
  type        = string
}
variable "cidr_block_subnet_private" {
  default     = "10.0.2.0/24"
  description = "cidr block for public subnet"
  type        = string
}
variable "cidr_block_db_subnet" {
  default     = "10.0.3.0/24"
  description = "cidr block for  subnet"
  type        = string
}
variable "vpc_id" {
  type        = string
  description = "var for vpc_id"
}
variable "azs" {
  description = "availability zone"
  default     = "eu-central-1a"
  type        = string
}