resource "aws_acm_certificate" "jeff_cert_tf" {
  domain_name = "jeff.aws.lab.bancey.xyz"
  validation_method = "DNS"

  tags = {
    Environment = "jeff-cert"
  }
  lifecycle {
    create_before_destroy = true
  }
}