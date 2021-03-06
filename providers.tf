provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "bucketjawnt"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfbackup"
  }
}
