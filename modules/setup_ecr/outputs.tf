# Get backend ecr repo url
output "ecr_backend_repo_url" {
  value = aws_ecr_repository.aws_lightfeather_backend_ecr.repository_url
}

# Get frontend ecr repo url
output "ecr_frontend_repo_url" {
  value = aws_ecr_repository.aws_lightfeather_frontend_ecr.repository_url
}