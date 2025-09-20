# This file: Module/Cloudfront/variables.tf
# This file defines input variables for the CloudFront distribution module in Terraform.
variable "domain_name" {
  description = "The domain name for the static website (e.g., example.com)"
  type        = string
}

# The subdomain for the website (e.g., www, dev).
# Useful if you want www.example.com or dev.example.com.
variable "acm_certificate_arn" {
  description = "The ARN of an ACM certificate for the subdomain_name"
  type        = string
}

# This variable holds the domain name of the Amazon S3 bucket that is acting as the origin for the CloudFront distribution.
variable "s3_bucket_domain" {
  description = "The domain name of the S3 bucket"
  type        = string
}







# The blocks here are Terraform variable declarations. 
#They are used to make Terraform configurations more flexible and reusable by defining input parameters 
#that can be specified at runtime instead of being hardcoded. 

# Here is an explanation of each variable:

# variable "domain_name"
# This variable is for the human-readable domain name that you want to use for your website, 
#such as www.example.com. 
# description: Provides a clear explanation of the variable's purpose. 
#It tells other users what value to provide.
# type: Specifies that the value must be a string. 
#This helps Terraform validate that the correct type of input is provided. 
# Purpose in the CloudFront setup: While this specific variable is not directly referenced 
#in the CloudFront resource block, it is likely used elsewhere in the Terraform configuration.
# For instance, it could be used to create a DNS record in AWS Route 53 that points your human-readable 
#domain (example.com) to the CloudFront distribution. 

# variable "acm_certificate_arn"
# This variable holds the Amazon Resource Name (ARN) of an SSL/TLS certificate. 
# description: Explains that the value should be the ARN of a certificate from AWS Certificate Manager (ACM). 
#This is the certificate that CloudFront will use to secure HTTPS connections.
# type: Specifies that the value must be a string. 
# Purpose in the CloudFront setup: The CloudFront viewer_certificate block uses this variable (var.acm_certificate_arn)
# to configure the distribution for HTTPS, ensuring that traffic between the user and CloudFront is encrypted. 

# variable "s3_bucket_domain"
# This variable holds the domain name of the Amazon S3 bucket that is acting as the origin for the
# CloudFront distribution. 
# description: Clearly states that this is the S3 bucket's domain name.
# type: Specifies that the value must be a string. 
# Purpose in the CloudFront setup: The CloudFront origin block uses this variable (var.s3_bucket_domain)
# to tell CloudFront where to fetch the website content from. 
# It's important to note that the S3 bucket's domain name is likely different from the domain name used for the website itself.

# How these variables are used together
# S3 bucket: Your website's static files are stored in an S3 bucket with a domain name 
#like my-website-bucket.s3.amazonaws.com.
# CloudFront: Your CloudFront distribution is configured to use the S3 bucket's domain 
#(from s3_bucket_domain) as its origin.
# ACM certificate: You create an ACM certificate for your custom domain (domain_name).
# Certificate linking: You reference the ARN of that certificate (from acm_certificate_arn) 
#in the CloudFront configuration.
# DNS (implicitly): You create a DNS record that points your custom domain (domain_name) 
#to the CloudFront distribution, using the ACM certificate to secure the connection. 