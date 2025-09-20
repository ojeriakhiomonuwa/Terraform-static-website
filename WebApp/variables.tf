# Variable Declarations
# ============================
# just declaring variables here no values
# ============================
# These variables define inputs for the Terraform configuration.
# They do not have values here, values can be passed via tfvars,
# CLI, or environment variables.
# ============================

# The AWS region where all resources (S3, CloudFront, Route 53, etc.) will be created.
variable "aws_region" {
  description = "The AWS region to create resources in"
}


# The root domain name for the static website (e.g., example.com).
# This will be used in Route 53 and CloudFront distribution setup.
variable "domain_name" {
  description = "The domain name for the static website (e.g., example.com)"
}

# The subdomain for the website (e.g., www, dev).
# Useful if you want www.example.com or dev.example.com.
variable "subdomain_name" {
  description = "The subdomain name for the static website (e.g., www, dev)"
}




# Local directory containing your static website files.
# These files will be uploaded to the S3 bucket for hosting.
variable "local_file_path" {
  description = "The local path to the static website files"
  type        = string
}


# The default index page of the static website.
# Typically "index.html", but can be overridden if needed.
variable "index_page" {
  description = "The path to the index page of the static website"
  default     = "index.html"
}
