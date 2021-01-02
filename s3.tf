resource "aws_s3_bucket" "alb_access_logs" {
  bucket = var.s3_bucket
  acl    = "public-read-write"
  policy = data.template_file.alb-temp.rendered

  tags = {
    Name        = "terraform-alb-access-jawnt"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "alb_private" {
  bucket                  = aws_s3_bucket.alb_access_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
