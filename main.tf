module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  availability_zone    = var.availability_zone
  public_subnet_2_cidr = var.public_subnet_2_cidr
  availability_zone_2  = var.availability_zone_2
}
module "s3" {
  source        = "./modules/s3"
  project_name  = var.project_name
  bucket_suffix = var.bucket_suffix
}

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  security_group_id = module.vpc.security_group_id
  subnet_ids = [
    module.vpc.public_subnet_id,
    module.vpc.public_subnet_2_id
  ]
  vpc_id      = module.vpc.vpc_id
  instance_id = module.ec2.instance_id
}