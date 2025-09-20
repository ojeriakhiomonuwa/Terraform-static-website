# terrafrom required version configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# aws provider configuration
provider "aws" {
  region = var.aws_region
}