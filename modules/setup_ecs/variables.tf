/*
Variables for ECS
*/

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "ecr_frontend_repo_url" {
  type   = string
  description = "ECR repo URL"
}  

variable "ecr_backend_repo_url" {
  type   = string
  description = "ECR repo URL"
} 

/*
Variables for Services and Tasks
*/
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_public_subnets" {
  type        = list
  description = "List of subnets"
  default     = []
}

variable "backend_image_tag" {
  type   = string
  description = "docker image tag"
}  

variable "frontend_image_tag" {
  type   = string
  description = "docker image tag"
}