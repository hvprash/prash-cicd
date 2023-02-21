# Create lb for backend service
resource "aws_alb" "backend_load_balancer" {
  name               = "lightfeather-backend" # Naming our load balancer
  load_balancer_type = "application"
  subnets = var.vpc_public_subnets
  security_groups = ["${aws_security_group.lb_backend_sg.id}"]
}

# SG for backend alb
resource "aws_security_group" "lb_backend_sg" {
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic in from all sources
  }

  egress {
    from_port   = 0 # Allowing any incoming port
    to_port     = 0 # Allowing any outgoing port
    protocol    = "-1" # Allowing any outgoing protocol 
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
  }
  vpc_id        = var.vpc_id
}

# Backend target group
resource "aws_lb_target_group" "lb_backend_target" {
  name        = "backend-target-group"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}

# Backend listener
resource "aws_lb_listener" "lb_backend_listener" {
  load_balancer_arn = "${aws_alb.backend_load_balancer.arn}"
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_backend_target.arn}"
  }
}