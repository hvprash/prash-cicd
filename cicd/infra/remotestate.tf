terraform {
  backend "s3" {
    bucket  = "prash-terraform-state"
    key     = "aws/cicd/infra/terraform.tfstate"
    region  = "us-east-1"
    encrypt = "true"
  }
}