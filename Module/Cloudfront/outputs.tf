# The file: Module/Cloudfront/outputs.tf
# This file defines outputs for the CloudFront distribution module in Terraform.
output "distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

#  This output provides the IAM ARN for the CloudFront Origin Access Identity (OAI),
# which is used to securely access the S3 bucket.
output "cf_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

# This output provides the automatically generated domain name of the CloudFront distribution,
# which can be used to access the static website.
output "cf_hosted_zone_id" {
    description = "The hosted zone ID of the CloudFront distribution"
    value       = aws_cloudfront_distribution.this.hosted_zone_id
    }






# The blocks provided here are Terraform output blocks. 
#These blocks define what data should be displayed on the console after a terraform apply 
#command has successfully completed. 
#They are used to retrieve information about resources that were created or modified by your 
#Terraform configuration. 

# output "cf_domain_name"
# This output block displays the automatically generated domain name of the CloudFront distribution. 
# description: A human-readable description explaining what the output value represents.
# value = aws_cloudfront_distribution.this.domain_name:
# aws_cloudfront_distribution.this: References the CloudFront distribution resource that was defined 
# earlier in your configuration (using the local name "this").
# .domain_name: Specifies the domain_name attribute of that resource. 
# CloudFront automatically generates a domain name for each distribution 
# (e.g., d604721fxaaqy9.cloudfront.net), and this output block will retrieve and display that value. 
# Purpose: This output is useful for a number of reasons:
# It provides the public URL that you can use immediately to access your static website.
# It can be used by other parts of your infrastructure, such as in a DNS record, 
# to point your custom domain to the CloudFront distribution. 

# output "cf_hosted_zone_id"
# This output block provides the hosted zone ID for the CloudFront distribution,
# which is needed to create a DNS record. 
# description: A description explaining that the output is the hosted zone ID.
# value = aws_cloudfront_distribution.this.hosted_zone_id:
# aws_cloudfront_distribution.this: Again, this refers to the CloudFront distribution resource.
# .hosted_zone_id: Retrieves the hosted_zone_id attribute of the distribution. This is a special, 
# canonical hosted zone ID for CloudFront that is used to create an "Alias" DNS record in Route 53. 
# Purpose: When setting up a custom domain (e.g., www.example.com) to work with CloudFront,
# you must create an "A" record of type "Alias" in your DNS. 
# This record points to the CloudFront distribution. 
# However, to do this, you need the hosted zone ID of the CloudFront distribution. 
# This output block provides that information. 
# Note: 
#The alias record requires the hosted zone ID of the target 
# (in this case, the CloudFront distribution) to function correctly.
# This output provides that specific ID, simplifying the process of automating your DNS setup. 