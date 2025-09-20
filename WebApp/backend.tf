#This file configures the remote backend for Terraform state management using an S3 bucket.
# It specifies the S3 bucket name, the key (path) for the state file, 
# the AWS region, and enables S3-native locking to prevent concurrent modifications.
# This configuration ensures that Terraform state is stored securely in an S3 bucket, 
# allowing for collaboration and state locking.

terraform {
  backend "s3" {
    bucket       = "s3-static-website-statefile-bucket"
    key          = "backend/statefile.tfstate"
    region       = "us-east-1"
    use_lockfile = true # Enable S3-native locking
  }
}