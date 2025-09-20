# This file defines outputs for the S3 bucket module in Terraform.
# These outputs provide useful information about the created S3 bucket,
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

# This output provides the regional domain name of the S3 bucket,
# which can be useful for accessing the bucket or configuring other services.
output "regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

# S3 website endpoint for CloudFront origin
output "website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}


# This output provides the ARN of the S3 bucket
output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}




# The code above defines outputs to display useful information about the S3 bucket.

# output "bucket_name" {
#   description = "The name of the S3 bucket."
#   # This will show the main bucket ID (name) after 'terraform apply'.
#   value = aws_s3_bucket.this.id
# }

# output "regional_domain_name" {
#   description = "The regional domain name of the S3 bucket. 
#This is useful for static website hosting and regional data access."
#   # This will show the regional domain name after 'terraform apply'.
#   value = aws_s3_bucket.this.bucket_regional_domain_name
# }
