# Looks up your EXISTING hosted zone (created earlier in the Route 53 console) —
# Terraform does not create the hosted zone itself, since your domain (GoDaddy)
# is already pointed at it.
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# www.srinayfoods.in -> CloudFront (HTTPS frontend)
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.www_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.frontend.domain_name
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
    evaluate_target_health = false
  }
}

# srinayfoods.in (bare domain) -> also CloudFront
resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.frontend.domain_name
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
    evaluate_target_health = false
  }
}

# api.srinayfoods.in -> EC2 Elastic IP (backend)
resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.api_subdomain}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.app_eip.public_ip]
}
