variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = "string"
  description = "vpc cidr variable"
}

variable "aws_region" {
  description = "this chooses the region"
  type        = "string"
  default     = "us-east-1"
}

variable "public_ip" {
  description = "uses 0.0.0.0/0"
  type        = "string"
  default     = "0.0.0.0/0"
}

variable "aws_image" {
  description = "aws ami used for nat instance"
  type        = "map"
  default = {
    us-east-1 = "ami-04d29b6f966df1537"
    us-east-2 = "ami-09558250a3419e7d0"

  }

}

variable "aws_instance_type" {
  description = "aws instance type for nat instance"
  type        = "string"
  default     = "t2.micro"
}

variable "aws_instance_name" {
  description = "use for webserver name"
  type        = "map"
  default = {
    Name = "WebServer"
  }
}

variable "web_tags" {
  type = "map"
  default = {
    Name = "WebServer"
  }
}

variable "web_ec2_count" {
  type    = "string"
  default = "2"
}

variable "s3_bucket" {
  type    = "string"
  default = "alb-access-logs-jawnt"
}

#variable s3_logs_bucket {
#type    = "string"
#default = "alb-access-logs-jawnt"
#}
