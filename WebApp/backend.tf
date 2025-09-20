# Remote backend for Terraform state storage
# Stores state file in S3 bucket for persistence and team collaboration

terraform {
  backend "s3" {
    bucket  = "s3-static-website-statefile-bucket"
    key     = "backend/statefile.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}