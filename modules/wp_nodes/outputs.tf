output "elb_dns_name" {
  value = aws_elb.ha-wp-elb.dns_name
}