# Input variables for Route53 DNS module

# Domain name to create DNS record for (e.g., www.ojes.online)
variable "domain_name" {
  description = "The domain name for the Route53 A record"
  type        = string
}

# CloudFront distribution domain name (e.g., d123456789.cloudfront.net)
variable "cf_domain" {
  description = "CloudFront distribution domain name"
  type        = string
}

# CloudFront hosted zone ID (required for alias records)
variable "cf_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID"
  type        = string
}

# Root domain for hosted zone lookup (e.g., ojes.online)
variable "root_domain" {
  description = "Root domain name for hosted zone lookup"
  type        = string
}