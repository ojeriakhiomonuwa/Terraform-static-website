# Remote backend with S3 native locking (requires Terraform 1.6+)
# Stores state in S3 and uses S3 object locking for concurrent access protection

terraform {
  backend "s3" {
    bucket         = "s3-static-website-statefile-bucket"
    key            = "backend/statefile.tfstate"
    region         = "us-east-1"
    use_lockfile   = true  # Enable S3 native locking (Terraform 1.6+)
  }
}