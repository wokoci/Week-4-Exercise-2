# Launch Template
resource "aws_launch_template" "web_server" {
  name_prefix   = "jeff-web-server"
  image_id      = "ami-0720a3ca2735bf2fa"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.private_appServer_SG.id]
  }

  user_data = base64encode(templatefile("user_data.sh.tpl", {
    db_endpoint = aws_db_instance.mysql_instance.address
  }))

  key_name = aws_key_pair.jeff_key_pair.key_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.environment}-jeff-asg-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name             = "jeff-web-asg"
  desired_capacity = 2
  max_size         = 4
  min_size         = 2
  target_group_arns = [aws_lb_target_group.app_tg.arn]
  vpc_zone_identifier = [aws_subnet.jeff_ec2_subnet4.id, aws_subnet.jeff_DB_subnet5.id]

  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "jeff-asg-instance"
    propagate_at_launch = true
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "jeff-scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "jeff-scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

# CloudWatch Alarms for Auto Scaling
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "jeff-high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }

  alarm_description = "Scale up if CPU utilization is above 80% for 4 minutes"
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "jeff-low-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }

  alarm_description = "Scale down if CPU utilization is below 20% for 4 minutes"
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}
