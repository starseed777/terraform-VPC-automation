locals {
  az_names = data.aws_availability_zones.azs.names
}

resource "aws_subnet" "publicsubnet" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "publicsubnet-${count.index + 1}"
  }
}
