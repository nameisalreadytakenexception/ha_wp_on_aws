# ELB
resource "aws_elb" "ha-wp-elb" {
  name                        = "ha-wp-elb"
  subnets                     = var.vpc_zone_identifier[0]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups             = [var.security_groups[0]]
  tags                        = { Name = "ha-wp-elb" }
  # access_logs {
  #   bucket        = "foo"
  #   bucket_prefix = "bar"
  #   interval      = 60
  # }
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  # listener {
  #   instance_port      = 8080
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  # }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

# EXEC_NODEs
data "aws_ami" "ha-wp-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_configuration" "ha-wp-launch-configuration" {
  name_prefix     = "ha-wp-exec-node-"
  image_id        = data.aws_ami.ha-wp-ubuntu.id
  instance_type   = var.node_instance_type
  key_name        = var.key_name
  security_groups = [var.security_groups[1]]
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF
  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_group" "ha-wp-autoscaling-group" {
  name                      = "ha-wp-autoscaling-group"
  launch_configuration      = aws_launch_configuration.ha-wp-launch-configuration.name
  max_size                  = var.node_count_max_size
  min_size                  = var.node_count_min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  vpc_zone_identifier       = var.vpc_zone_identifier[1]
  load_balancers            = [aws_elb.ha-wp-elb.id]
  lifecycle { create_before_destroy = true }
  tags = [{ Name = "ha-wp-node" }]
}