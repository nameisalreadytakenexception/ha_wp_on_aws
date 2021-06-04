resource "aws_route53_zone" "ha-wp-route53-zone" {
  name = "ha-wp.com"
  force_destroy = true
  vpc {
    vpc_id = var.vpc_id
  }
}
data "aws_elb_hosted_zone_id" "main" {}
resource "aws_route53_record" "ha-wp-route53-record" {
  zone_id = aws_route53_zone.ha-wp-route53-zone.zone_id
  name    = "ha-wp.com"
  type    = "A"
  alias {
    name                   = var.elb_dns_name
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }
}