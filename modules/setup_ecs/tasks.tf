# Create ECS tasks
resource "aws_ecs_task_definition" "lightfeather_backend_task" {
  family                   = "${var.app_name}-backend-task"
  container_definitions    = jsonencode([
    {
      name      = "${var.app_name}-backend-task"
      image     = "${var.ecr_backend_repo_url}:${var.backend_image_tag}"
      logConfiguration = {
        logDriver = "awslogs"
        options  = {
        awslogs-group  = "${aws_cloudwatch_log_group.ecs-log-backend-group.id}"
        awslogs-region = "us-east-1"
        awslogs-stream-prefix =  "${var.app_name}"
        }
      }
      portMappings  = [
        {
          containerPort  = 8080
          hostPort       = 8080
        }
      ]
      environment = [
        {
          name   =  "BACKEND_HOST",
          value  =  "lightfeather-frontend-1699696571.us-east-1.elb.amazonaws.com"
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"] # Fargate for launching the instances on demand
  network_mode             = "awsvpc"    # Use VPC for fargate
  memory                   = 512       # memory req for the task
  cpu                      = 256         # cpu req for the task
  execution_role_arn       = "${aws_iam_role.ecs_task_role.arn}"
}

resource "aws_ecs_task_definition" "lightfeather_frontend_task" {
  family                   = "${var.app_name}-frontend-task"
  container_definitions    = jsonencode([
    {
      name      = "${var.app_name}-frontend-task"
      image     = "${var.ecr_frontend_repo_url}:${var.frontend_image_tag}"
      logConfiguration = {
        logDriver = "awslogs"
        options  = {
        awslogs-group  = "${aws_cloudwatch_log_group.ecs-log-frontend-group.id}"
        awslogs-region = "us-east-1"
        awslogs-stream-prefix =  "${var.app_name}"
        }
      }
      portMappings  = [
        {
          containerPort  = 3000
          hostPort       = 3000
        }
      ]
      environment = [
        {
          name   =  "API_URL",
          value  =  "http://lightfeather-backend-1367116791.us-east-1.elb.amazonaws.com:8080"
        }
      ]    
    }
  ])
  requires_compatibilities = ["FARGATE"] # Fargate for launching the instances on demand
  network_mode             = "awsvpc"    # Use VPC for fargate
  memory                   = 512         # memory req for the task
  cpu                      = 256         # cpu req for the task
  execution_role_arn       = "${aws_iam_role.ecs_task_role.arn}"
}