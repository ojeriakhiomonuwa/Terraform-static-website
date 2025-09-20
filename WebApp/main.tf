# =============================================================================
# ROOT MODULE: STATIC WEBSITE INFRASTRUCTURE
# =============================================================================
# This is the main Terraform configuration that orchestrates all components
# to create a secure, scalable static website on AWS.
#
# ARCHITECTURE OVERVIEW:
# 1. S3 Bucket      - Stores website files (HTML, CSS, JS, images)
# 2. CloudFront     - Global CDN for fast content delivery + HTTPS
# 3. Route53        - DNS routing from custom domain to CloudFront
# 4. ACM            - SSL/TLS certificates for HTTPS encryption
#
# RESULT: https://www.ojes.online - Secure, fast static website
# =============================================================================

# -----------------------------------------------------------------------------
# SSL CERTIFICATE LOOKUP
# -----------------------------------------------------------------------------
# Finds an existing SSL certificate in AWS Certificate Manager (ACM)
# This certificate was created manually and covers *.ojes.online
data "aws_acm_certificate" "cert" {
  provider    = aws.us_east_1      # ACM certificates for CloudFront must be in us-east-1
  domain      = "*.ojes.online"    # Wildcard certificate covers www.ojes.online
  statuses    = ["ISSUED"]         # Only look for successfully issued certificates
  most_recent = true               # Get the newest certificate if multiple exist
}

# -----------------------------------------------------------------------------
# S3 BUCKET MODULE
# -----------------------------------------------------------------------------
# Creates and configures S3 bucket for static website hosting
# - Uploads all website files from local directory
# - Configures bucket for public read access
# - Sets up static website hosting (index.html, error.html)
module "s3_bucket" {
  source      = "../Module/S3-buckets"                        # Path to S3 module
  bucket_name = "${var.subdomain_name}.${var.domain_name}"    # Creates: www.ojes.online
}

# -----------------------------------------------------------------------------
# CLOUDFRONT DISTRIBUTION MODULE
# -----------------------------------------------------------------------------
# Creates CloudFront CDN distribution for global content delivery
# - Points to S3 bucket as origin
# - Enforces HTTPS (redirects HTTP to HTTPS)
# - Uses SSL certificate for custom domain
# - Caches content globally for fast loading
module "cloudfront" {
  depends_on = [module.s3_bucket]                             # Wait for S3 bucket to be ready
  
  source              = "../Module/Cloudfront"                # Path to CloudFront module
  domain_name         = "${var.subdomain_name}.${var.domain_name}"  # www.ojes.online
  acm_certificate_arn = data.aws_acm_certificate.cert.arn    # SSL certificate for HTTPS
  s3_bucket_domain    = module.s3_bucket.website_endpoint    # S3 website endpoint as origin
}

# -----------------------------------------------------------------------------
# ROUTE53 DNS RECORD MODULE
# -----------------------------------------------------------------------------
# Creates DNS A record to route custom domain to CloudFront
# - Maps www.ojes.online → CloudFront distribution
# - Uses alias record (not CNAME) for better performance
# - Looks up hosted zone for ojes.online
module "route53_record" {
  source            = "../Module/Route53"                     # Path to Route53 module
  domain_name       = "${var.subdomain_name}.${var.domain_name}"  # www.ojes.online (A record)
  root_domain       = var.domain_name                        # ojes.online (hosted zone lookup)
  cf_domain         = module.cloudfront.cf_domain_name       # CloudFront domain (target)
  cf_hosted_zone_id = module.cloudfront.cf_hosted_zone_id    # CloudFront zone ID (required for alias)
}

# =============================================================================
# WORKFLOW SUMMARY:
# 1. Terraform reads this configuration
# 2. Creates S3 bucket and uploads website files
# 3. Creates CloudFront distribution pointing to S3
# 4. Creates Route53 A record pointing to CloudFront
# 5. Result: https://www.ojes.online serves your static website securely!
# =============================================================================
