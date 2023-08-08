resource "aws_vpc" "two-tier-vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "2tier-vpc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count             = 4
  cidr_block        = "${cidrsubnet(aws_vpc.two-tier-vpc.cidr_block, 8, count.index + 1)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index >=2 ? (count.index)-2 : count.index]}"
  vpc_id            = aws_vpc.two-tier-vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.subnets[count.index]}"
  }
}

//resource "aws_subnet" "webtier-public-subnet1" {
//  cidr_block = "172.33.1.0/24"
//  availability_zone = var.
//
//  vpc_id = aws_vpc.2tier-vpc.id
//  map_public_ip_on_launch = true
//
//}
//
//resource "aws_subnet" "webtier-public-subnet2" {
//  cidr_block = "172.33.2.0/24"
//  vpc_id = aws_vpc.2tier-vpc.id
//
//}
//
//resource "aws_subnet" "dbtier-private-subnet1" {
//  cidr_block = "172.33.3.0/24"
//  vpc_id = aws_vpc.2tier-vpc.id
//}
//
//resource "aws_subnet" "dbtier-private-subnet1" {
//  cidr_block = "172.33.4.0/24"
//  vpc_id = aws_vpc.2tier-vpc.id
//}

