# Create IAM role for ECS to pull images from ECR
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-ecs-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  tags = {
    Name        = "${var.app_name}-iam-role"
  }
}

# Attach IAM policy to role
resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Create ECS cluster
resource "aws_ecs_cluster" "lightfeather_ecs_cluster" {
  name = "${var.app_name}-cluster"
}

# Create Log Group - Frontend
resource "aws_cloudwatch_log_group" "ecs-log-frontend-group" {
  name = "${var.app_name}-frontend-logs"

  tags = {
    Application = var.app_name
  }
}

# Create Log Group - Backend
resource "aws_cloudwatch_log_group" "ecs-log-backend-group" {
  name = "${var.app_name}-backend-logs"

  tags = {
    Application = var.app_name
  }
}