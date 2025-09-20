# Creates a CloudFront Origin Access Identity (OAI) to securely access private S3 bucket content
###############################################################
# CloudFront Distribution Module
#
# This module creates a CloudFront distribution for serving a static website
# from a private S3 bucket. It also creates an Origin Access Identity (OAI)
# to securely allow CloudFront to access the S3 bucket contents.
###############################################################

# Creates a CloudFront Origin Access Identity (OAI) to securely access private S3 bucket content
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for S3 static website"
}
resource "aws_cloudfront_distribution" "this" {
  # Defines the S3 origin for CloudFront and configures it to use the OAI
  origin {
    domain_name = var.s3_bucket_domain
    origin_id   = "s3-origin"

    # This block configures CloudFront to use the OAI for accessing the S3 bucket. 
    s3_origin_config {
  origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
}
  }

  # Enables the distribution and sets the default root object
  enabled             = true
  default_root_object = "index.html"

  # Default cache behavior for the distribution
  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    # Using managed cache policies is the recommended approach for CloudFront distributions.
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"  # Managed-CachingDisabled
  }

  # Configures SSL certificate for HTTPS
  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

  # Domain aliases for the distribution
  aliases = [var.domain_name]

  # No geo restrictions (serves globally)
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}