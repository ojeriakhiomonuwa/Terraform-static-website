# This file: Module/Route53/main.tf
# This file creates a Route 53 DNS record to point a custom domain to a CloudFront distribution.
resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"
# An "A" record maps a domain name to an IPv4 address.
  alias {
    name                   = var.cf_domain
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

# This block of code retrieves information about an existing Route 53 hosted zone by name. 
# It is used to get the zone ID needed to create the DNS record in the correct hosted zone.
data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}






# The code here is a Terraform configuration for creating a DNS record in Amazon Route 53 
#that points a custom domain name to an AWS CloudFront distribution. 

# It uses two main components:
# A data block to look up an existing Route 53 hosted zone.
# A resource block to create a new A record within that zone. 

# resource "aws_route53_record" "alias"
# This block creates the DNS record that will map your custom domain to the CloudFront distribution. 
# It creates a special type of record known as an "Alias" record, which functions similarly to a 
# CNAME but can be used for the root domain (the "zone apex," like example.com). 
# zone_id = data.aws_route53_zone.this.zone_id: Gets the ID of the hosted zone from the data block, 
# which ensures the record is created in the correct DNS zone.

# name = var.domain_name: The name of the record, which is set to the custom domain name
# (e.g., www.example.com or example.com).
# type = "A": Specifies that this is an A record, which maps a domain name to an IPv4 address.
# alias { ... }: This special block is what makes the record an alias. It configures the target of the alias.
# name = var.cf_domain: The alias target is the domain name of the CloudFront distribution, retrieved
# from the variable cf_domain.

# zone_id = var.cf_hosted_zone_id: The hosted zone ID of the CloudFront distribution. 
# Route 53 requires this special ID to link to the CloudFront target.

# evaluate_target_health = false: This tells Route 53 not to check the health of the 
# CloudFront distribution. For a CloudFront alias, this is the standard practice, 
# as CloudFront's own health checks are handled internally. 
# data "aws_route53_zone" "this"

# This block is a data source, which means it retrieves information about an existing resource 
# in AWS rather than creating a new one. In this case, it looks up an existing Route 53 hosted zone by name. 

# name = var.domain_name: The data source looks for a hosted zone with a name that matches the
# domain_name variable (e.g., example.com.).


# private_zone = false: Specifies that the hosted zone it's looking for is a public one, 
#not a private one associated with a VPC. 

# How they work together
# Retrieve Hosted Zone ID: The data "aws_route53_zone" block first queries AWS to find the Hosted Zone ID
# for your custom domain (e.g., example.com).
# Create DNS Record: The resource "aws_route53_record" block then uses this retrieved zone_id to
# create an A record inside that hosted zone.
# Point to CloudFront: The alias block within the record maps your custom domain 
#to the CloudFront distribution's domain name (cf_domain) and hosted zone ID (cf_hosted_zone_id), 
# effectively directing all traffic for your custom domain to your CloudFront distribution. 