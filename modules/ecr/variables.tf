variable "ecr_name" {
  description = "The name of the ECR registry"
  type        = string
}
variable "image_mutability" {
  description = "Provide image mutability"
  type        = string
}
variable "encrypt_type" {
  description = "Provide type of encryption here"
  type        = string
}
variable "aws_region" {
  type        = string
  description = "Region"
}
variable "tag_project_name" {
  type        = string
  description = "Tag project name"
}
