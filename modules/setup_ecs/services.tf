## Backend Service and ALB configs
resource "aws_ecs_service" "lightfeather_backend_service" {
  name            = "lightfeather_backend_service"
  cluster         = "${aws_ecs_cluster.lightfeather_ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.lightfeather_backend_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = "${aws_lb_target_group.lb_backend_target.arn}"
    container_name   = "${var.app_name}-backend-task"
    container_port   = 8080
  }

  network_configuration {
    subnets          = var.vpc_public_subnets
    assign_public_ip = true
    security_groups  = ["${aws_security_group.lightfeather_backend_service_sg.id}"]
  }
  depends_on = [aws_lb_listener.lb_backend_listener]
}

resource "aws_security_group" "lightfeather_backend_service_sg" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = ["${aws_security_group.lb_backend_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id        = var.vpc_id
}

## Frontend Service and ALB configs
resource "aws_ecs_service" "lightfeather_frontend_service" {
  name            = "lightfeather_frontend_service"
  cluster         = "${aws_ecs_cluster.lightfeather_ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.lightfeather_frontend_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = "${aws_lb_target_group.lb_frontend_target.arn}"
    container_name   = "${var.app_name}-frontend-task"
    container_port   = 3000
  }

  network_configuration {
    subnets          = var.vpc_public_subnets
    assign_public_ip = true
    security_groups  = ["${aws_security_group.lightfeather_frontend_service_sg.id}"]
  }
  depends_on = [aws_lb_listener.lb_frontend_listener]
}

resource "aws_security_group" "lightfeather_frontend_service_sg" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = ["${aws_security_group.lb_frontend_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id        = var.vpc_id
}