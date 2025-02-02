data "aws_route53_zone" "hosted_zone" {
  name = var.acm_root_domain
}

resource "aws_route53_record" "site_sub_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "jeff.aws.lab.bancey.xyz"
  type    = "A"
  alias {
    name                   = aws_lb.jeff-app_load_balancer.dns_name
    zone_id                = aws_lb.jeff-app_load_balancer.zone_id
    evaluate_target_health = true
  }
  
}

