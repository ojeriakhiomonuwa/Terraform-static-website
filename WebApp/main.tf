###############################################################
# Root Module: Static Website Infrastructure
#
# This file wires together the S3 bucket, CloudFront distribution,
# and Route53 DNS record modules to deploy a secure static website.
###############################################################

# S3 Bucket Module
# Creates an S3 bucket for website files and configures access for CloudFront
module "s3_bucket" {
  source      = "../Module/S3-buckets"
  bucket_name = "${var.subdomain_name}.${var.domain_name}"
  # Passes the CloudFront OAI IAM ARN to the S3 bucket module for secure access
  oai_iam_arn = module.cloudfront.oai_iam_arn
}
###############################################################
# CloudFront Distribution Module
# Creates a CloudFront distribution to serve the static website securely
module "cloudfront" {
  source              = "../Module/Cloudfront"
  domain_name         = "${var.subdomain_name}.${var.domain_name}"
  acm_certificate_arn = data.aws_acm_certificate.cert.arn
  # Passes the S3 bucket domain name to CloudFront for origin configuration
  s3_bucket_domain = module.s3_bucket.regional_domain_name
}

# Fetch the most recent issued ACM certificate for the domain
data "aws_acm_certificate" "cert" {
  domain      = "*.ojes.online"
  statuses    = ["ISSUED"]
  most_recent = true
}



###############################################################
# Route53 DNS Record Module
# Creates an alias A record to point your domain to the CloudFront distribution. 
module "route53_record" {
  source            = "../Module/Route53"
  domain_name       = var.domain_name
  cf_domain         = module.cloudfront.cf_domain_name
  cf_hosted_zone_id = module.cloudfront.cf_hosted_zone_id
}
