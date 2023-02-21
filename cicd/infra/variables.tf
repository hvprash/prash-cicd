## Variables for provider

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}


## Variables for VPC

variable "app_name" {
  type        = string
  description = "Application Name"
}


variable "public_subnets" {
  description = "List of public subnets"
}


variable "azs" {
  description = "List of availability zones"
}

## Variables for services and tasks
variable "backend_image_tag" {
  type   = string
  description = "docker image tag"
}  

variable "frontend_image_tag" {
  type   = string
  description = "docker image tag"
}