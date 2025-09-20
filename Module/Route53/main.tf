# DNS A record to route custom domain to CloudFront distribution
resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.this.zone_id  # Hosted zone ID from data source below
  name    = var.domain_name                     # Domain to create record for (e.g., www.ojes.online)
  type    = "A"                                 # A record type (maps domain to IP addresses)
  
  # Alias configuration points to CloudFront instead of IP addresses
  alias {
    name                   = var.cf_domain           # CloudFront distribution domain
    zone_id                = var.cf_hosted_zone_id   # CloudFront's hosted zone ID
    evaluate_target_health = false                   # Don't check CloudFront health (handled internally)
  }
}

# Look up existing Route53 hosted zone for the root domain
data "aws_route53_zone" "this" {
  name         = var.root_domain  # Root domain (e.g., ojes.online)
  private_zone = false            # Public hosted zone (not VPC-internal)
} 