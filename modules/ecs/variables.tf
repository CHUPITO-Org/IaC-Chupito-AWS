variable "vpc_id" {
  type    = string
  description = "VPC CIDR block"
}
variable "public_subnets_ids" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}
variable "private_subnets_ids" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}
variable "documentdb_username" {
  description = "Username for documentDB"
  type        = string
}
variable "documentdb_password" {
  description = "Password for documentDB"
  type        = string
}
variable "documentdb_endpoint" {
  description = "DocumentDB endpoint"
  type        = string
}
variable "documentdb_name" {
  description = "DocumentDB name"
  type        = string
}
variable "tag_project_name" {
  type        = string
  description = "Tag project name"
}
variable "account_id" {
  type        = string
  description = "AWS Account ID"
}




