module "vpc_aws" {
  source                = "./modules/vpc_manual"
  aws_region            = var.aws_region
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  azs                   = var.azs
}
