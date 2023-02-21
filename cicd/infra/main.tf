# Setup VPC, Subnet and Routing Table for Lighfeather App
module "setup_vpc_subnet" {
 source          = "../../modules/setup_vpc" 
 aws_access_key  = var.aws_access_key
 aws_secret_key  = var.aws_secret_key
 aws_region      = var.aws_region
 app_name        = var.app_name
 public_subnets  = var.public_subnets
 azs             = var.azs
}

# Create container registry to artifact the Lightfeather docker images
module "setup_ecr" {
 source          = "../../modules/setup_ecr" 
 app_name        = var.app_name

 depends_on      = [
  module.setup_vpc_subnet
 ]
}

# Create container registry to artifact the Lightfeather docker images
module "setup_ecs" {
 source          = "../../modules/setup_ecs" 
 app_name        = var.app_name
 ecr_backend_repo_url    = module.setup_ecr.ecr_backend_repo_url
 ecr_frontend_repo_url   = module.setup_ecr.ecr_frontend_repo_url
 vpc_id                  = module.setup_vpc_subnet.vpc_id
 vpc_public_subnets      = module.setup_vpc_subnet.vpc_public_subnets
 backend_image_tag       = var.backend_image_tag
 frontend_image_tag      = var.frontend_image_tag

 depends_on      = [
  module.setup_ecr
 ]
}

