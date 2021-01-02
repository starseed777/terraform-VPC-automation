locals {
  env_tag = {
    Environment = terraform.workspace
  }
  web_tags = merge(var.web_tags, local.env_tag)
}

resource "aws_instance" "web" {
  count                = var.web_ec2_count
  ami                  = var.aws_image[var.aws_region]
  instance_type        = var.aws_instance_type
  subnet_id            = local.pub_sub_ids[count.index]
  user_data            = file("scripts/apache.sh")
  tags                 = local.web_tags
  iam_instance_profile = aws_iam_instance_profile.s3_ec2_profile.name
  key_name             = aws_key_pair.webkey.key_name
  security_groups      = [aws_security_group.nat_sg.id]
}

resource "aws_key_pair" "webkey" {
  key_name   = "webkeypair"
  public_key = file("scripts/web.pub")
}
