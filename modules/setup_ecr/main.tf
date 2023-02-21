# Create container registry repo - lightfeather-backend
resource "aws_ecr_repository" "aws_lightfeather_backend_ecr" {
  name = "${var.app_name}-backend-ecr"
  tags = {
    Name        = "${var.app_name}-backend-ecr"
  }
}

# Create container registry repo - lightfeather-frontend
resource "aws_ecr_repository" "aws_lightfeather_frontend_ecr" {
  name = "${var.app_name}-frontend-ecr"
  tags = {
    Name        = "${var.app_name}-frontend-ecr"
  }
}