resource "aws_internet_gateway" "two-tier-IGW" {
  vpc_id = aws_vpc.two-tier-vpc.id
  tags   = {
    Name = "2tier-IGW"
}
}



