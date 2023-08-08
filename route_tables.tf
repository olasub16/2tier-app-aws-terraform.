# Creating route table for webtier
resource "aws_route_table" "webtier-RT" {
  vpc_id = aws_vpc.two-tier-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.two-tier-IGW.id
  }
  tags = {
    Name = "webtier-RT"
  }
}

# associating subnet with route table for web tier
resource "aws_route_table_association" "webtier-sub-association" {
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.webtier-RT.id
  count = 2

}

# creating route table for rds tier
resource "aws_route_table" "rdstier-RT" {
  vpc_id = aws_vpc.two-tier-vpc.id
  tags = {
    Name ="RDStier-RT"
  }
}

# associating subnet with route table for rds tier
resource "aws_route_table_association" "rdstier-sub-association" {
  subnet_id      = aws_subnet.subnets[count.index+2].id
  route_table_id = aws_route_table.rdstier-RT.id
  count = 2
}

