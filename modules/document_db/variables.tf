variable "vpc_id" {
  type = string
}

variable "db_subnets_ids" {
  description = "Private Subnet CIDR values"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "documentdb_username" {
  description = "Username for documentDB"
  type        = string
}

variable "documentdb_password" {
  description = "Password for documentDB"
  type        = string
}