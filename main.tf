module "vpc_aws" {
  source                = "./modules/vpc_manual"
  aws_region            = var.aws_region
  vpc_cidr_block        = var.vpc_cidr_block
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  azs                   = var.azs
}

module "container_registry" {
  source           = "./modules/ecr"
  aws_region       = var.aws_region
  ecr_name         = var.ecr_name
  image_mutability = var.image_mutability
  encrypt_type     = var.encrypt_type
}

module "ecs_fargate" {
  source              = "./modules/ecs"
  vpc_id              = module.vpc_aws.vpc_id
  public_subnets_ids  = module.vpc_aws.public_subnets_ids
  private_subnets_ids = module.vpc_aws.private_subnets_ids
  documentdb_username = var.documentdb_username
  documentdb_password = module.secrets_manager.documentdb_root_password
  documentdb_endpoint = module.document_db.documentdb_endpoint
  documentdb_name     = module.document_db.documentdb_name
}

module "secrets_manager" {
  source              = "./modules/secrets_manager"
  documentdb_username = var.documentdb_username
}

module "document_db" {
  source              = "./modules/document_db"
  vpc_id              = module.vpc_aws.vpc_id
  db_subnets_ids      = module.vpc_aws.db_subnets_ids
  azs                 = var.azs
  documentdb_username = var.documentdb_username
  documentdb_password = module.secrets_manager.documentdb_root_password
  documentdb_pg_tls   = var.documentdb_pg_tls

  depends_on = [module.secrets_manager]
}

module "bastion_host" {
  source              = "./modules/bastion"
  vpc_id              = module.vpc_aws.vpc_id
  public_subnets_ids  = module.vpc_aws.public_subnets_ids
  ec2_ami             = var.ec2_ami
  instance_type       = var.instance_type
}
