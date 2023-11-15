module "vpc_aws" {
  source                = "./modules/vpc_manual"
  aws_region            = var.aws_region
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  azs                   = var.azs
}

module "ecr-repo" {
  source           = "./modules/ecr"
  aws_region       = var.aws_region
  ecr_name         = var.ecr_name
  image_mutability = var.image_mutability
  encrypt_type     = var.encrypt_type
  tags             = var.tags
}