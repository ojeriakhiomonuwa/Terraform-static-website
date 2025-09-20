# CloudFront CDN distribution for global content delivery
resource "aws_cloudfront_distribution" "this" {
  # Configure S3 website as the origin (where content comes from)
  origin {
    domain_name = var.s3_bucket_domain  # S3 website endpoint (e.g., bucket.s3-website-us-east-1.amazonaws.com)
    origin_id   = "s3-website-origin"

    # Custom origin config for S3 website endpoints (not REST API)
    custom_origin_config {
      http_port              = 80          # Standard HTTP port
      https_port             = 443         # Standard HTTPS port
      origin_protocol_policy = "http-only" # S3 website endpoints only support HTTP
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true         # Activate the distribution
  default_root_object = "index.html" # Default file to serve at root URL

  # How CloudFront handles requests and caching
  default_cache_behavior {
    target_origin_id       = "s3-website-origin"
    viewer_protocol_policy = "redirect-to-https"    # Force HTTPS for security
    allowed_methods        = ["GET", "HEAD"]        # Only allow read operations
    cached_methods         = ["GET", "HEAD"]        # Cache these methods
    compress               = true                    # Compress files for faster delivery

    # AWS managed policies for optimal performance
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"          # CachingOptimized
    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # CORS-S3Origin
  }

  # SSL certificate configuration for custom domain
  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn    # SSL certificate from ACM
    ssl_support_method  = "sni-only"                 # Modern SSL method
    minimum_protocol_version = "TLSv1.2_2019"       # Secure TLS version
  }

  aliases = [var.domain_name]  # Custom domain (e.g., www.ojes.online)

  # Geographic restrictions (none = serve globally)
  restrictions {
    geo_restriction {
      restriction_type = "none"  # No geographic blocking
    }
  }
}