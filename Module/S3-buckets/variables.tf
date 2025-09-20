# This file defines input variables for the S3 bucket module in Terraform.
# These variables allow customization of the S3 bucket's name and the IAM ARN for CloudFront
# These variables can be set when the module is called from the root module.
# If not set, the bucket_name variable defaults to "minifinance-bucket".

# The oai_iam_arn variable must be provided to ensure secure access from CloudFront.
# This variable holds the IAM ARN for the CloudFront Origin Access Identity (OAI).
# It is used in the S3 bucket policy to restrict access to the bucket only to CloudFront.
# This enhances security by preventing direct public access to the S3 bucket.
variable "oai_iam_arn" {
  description = "IAM ARN for CloudFront Origin Access Identity"
  type        = string
}

# This variable sets the name of the S3 bucket to be created.
# It has a default value of "minifinance-bucket" but can be overridden
variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
  default     = "www.ojes.online" # Why this matters:
# If you’re using S3 static website hosting directly, 
# the bucket name must match the domain (e.g. www.ojes.online) for DNS aliasing to work properly.
# If you’re using CloudFront, it’s not mandatory, 
#but keeping the bucket name aligned with your domain avoids confusion and makes management easier.
}




# variable "bucket_name":
# This declares a variable with the identifier bucket_name.
# When this configuration is applied, a value will be assigned to this variable.
# description = "The name of the S3 bucket to create":
# This provides a human-readable description of the variable's purpose. 
#It explains that bucket_name is intended to store the name for an Amazon S3 bucket that will be created.
# This helps in understanding the code and its intent.
# type = string:
# This specifies the data type of the bucket_name variable.
# In this case, it indicates that the value assigned to bucket_name must be a string (i.e., a sequence of characters).
# default = "minifinance-bucket":
# This sets a default value for the bucket_name variable.
#If no explicit value is provided for bucket_name when the configuration is executed,
# it will automatically use "minifinance-bucket" as its value. 
#This provides a convenient fallback and can be overridden if a different bucket name is desired.