resource "aws_lb_target_group" "albtg" {
  name     = "ALB-TG-${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count            = var.web_ec2_count
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.web.*.id[count.index]
  port             = 80
}

resource "aws_lb" "alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = local.pub_sub_ids
  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    enabled = true
  }

  tags = {
    Environment = terraform.workspace
  }
}

resource "aws_lb_listener" "web_tg" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn

  }
}

data "template_file" "alb-temp" {
  template = file("scripts/iam/alblogs.json")
  vars = {
    access_logs_bucket = "alb-access-logs-jawnt"
    prefix             = "alb-logs"
  }
}
