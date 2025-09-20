# Input variables for S3 bucket module

# S3 bucket name (passed from root module)
variable "bucket_name" {
  description = "Name of the S3 bucket to create (e.g., www.ojes.online)"
  type        = string
  default     = "www.ojes.online"
}