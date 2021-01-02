locals {
  pub_sub_ids = aws_subnet.publicsubnet.*.id
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = var.public_ip
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRT-${terraform.workspace}"
  }
}

resource "aws_route_table_association" "pub_sub_association" {
  count          = length(local.az_names)
  route_table_id = aws_route_table.publicRT.id
  subnet_id      = aws_subnet.publicsubnet.*.id[count.index]
}
