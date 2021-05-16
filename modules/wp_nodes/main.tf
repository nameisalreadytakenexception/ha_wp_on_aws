data "aws_ami" "ha-wp-ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "ha-wp-launch-configuration" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.ha-wp-ubuntu.id
  instance_type = var.node_instance_type
  lifecycle { create_before_destroy = true }
  security_groups = var.security_groups
}

resource "aws_autoscaling_group" "ha-wp-autoscaling-group" {
  name                 = "ha-wp-autoscaling-group"
  launch_configuration = aws_launch_configuration.ha-wp-launch-configuration.name
  max_size             = var.node_count_max_size
  min_size             = var.node_count_min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  vpc_zone_identifier       = [var.vpc_zone_identifier[0], var.vpc_zone_identifier[1]]
  # load_balancers = 
  tags                      = [{ Name = "ha-wp-node" }]
}