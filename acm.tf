# CloudFront requires its certificate to live in us-east-1, so this uses
# the aliased provider defined in providers.tf regardless of var.aws_region.

resource "aws_acm_certificate" "site_cert" {
  provider                 = aws.us_east_1
  domain_name               = var.www_domain_name
  subject_alternative_names = [var.domain_name]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = { Name = "${var.project_name}-cert" }
}

# Automatically creates the CNAME validation records in your existing
# Route 53 hosted zone, so you don't have to copy/paste them manually.
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.site_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "site_cert" {
  provider                = aws.us_east_1
  certificate_arn          = aws_acm_certificate.site_cert.arn
  validation_record_fqdns  = [for record in aws_route53_record.cert_validation : record.fqdn]
}
