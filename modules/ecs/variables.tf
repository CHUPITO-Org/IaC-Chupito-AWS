variable "vpc_id" {
  type = string
}
variable "public_subnets_ids" {
  type = list(string)
}
variable "private_subnets_ids" {
  type = list(string)
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