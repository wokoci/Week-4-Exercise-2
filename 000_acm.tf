
resource "aws_acm_certificate" "jeff_cert_tf" {
  domain_name               = "${var.environment}.${var.acm_root_domain}"
  subject_alternative_names = ["*.${var.environment}.${var.acm_root_domain}"]
  validation_method         = "DNS"

  tags = {
    Environment = "${var.project_name}-${var.environment}-jeff-cert"
  }
  lifecycle {
    create_before_destroy = true
  }
}

#get details about a route 53 hosted zone
data "aws_route53_zone" "jeff_route53_zone_root_domain" {
  name         = var.acm_root_domain
  private_zone = false
}

resource "aws_route53_record" "aws_route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.jeff_cert_tf.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.jeff_route53_zone_root_domain.zone_id
}

resource "aws_acm_certificate_validation" "vert_validation" {
  certificate_arn         = aws_acm_certificate.jeff_cert_tf.arn
  validation_record_fqdns = [for record in aws_route53_record.aws_route53_record : record.fqdn]
}
