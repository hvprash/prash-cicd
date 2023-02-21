output "vpc_public_subnets" {
  value = module.setup_vpc_subnet.vpc_public_subnets 
}

# output "vpc_private_subnets" {
#   value = module.setup_vpc_subnet.vpc_private_subnets 
# }