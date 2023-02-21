# Export public subnet ids
output "vpc_public_subnets" {
  value = aws_subnet.public_subnets.*.id
}

# Export VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}