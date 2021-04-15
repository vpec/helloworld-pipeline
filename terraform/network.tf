resource "aws_vpc" "development-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Development-VPC"
  }
}
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "us-east-2a"
  tags = {
    Name = "Development-Public-Subnet-1"
  }
}
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "Development-Public-RouteTable"
  }
}
resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}
resource "aws_subnet" "private-subnet-1" {
  cidr_block        = "10.0.10.0/24"
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "us-east-2a"
  tags = {
    Name = "Development-Private-Subnet-1"
  }
}
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "Development-Private-RouteTable"
  }
}
resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}
resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  tags = {
    Name = "Development-EIP"
  }
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = {
    Name = "Development-NATGW"
  }
  depends_on = [aws_eip.elastic-ip-for-nat-gw]
}
resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_internet_gateway" "development-igw" {
  vpc_id = aws_vpc.development-vpc.id
  tags = {
    Name = "Development-IGW"
  }
}
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.development-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
