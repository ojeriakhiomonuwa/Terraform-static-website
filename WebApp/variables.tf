# Input variables for root module (values set in terraform.tfvars)

# AWS region for all resources
variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
}

# Root domain name (e.g., ojes.online)
variable "domain_name" {
  description = "Root domain name for the website"
  type        = string
}

# Subdomain prefix (e.g., www)
variable "subdomain_name" {
  description = "Subdomain prefix (creates www.ojes.online)"
  type        = string
}

# Local path to website files
variable "local_file_path" {
  description = "Local directory containing website files"
  type        = string
}

# Default index page
variable "index_page" {
  description = "Default index page for the website"
  type        = string
  default     = "index.html"
}