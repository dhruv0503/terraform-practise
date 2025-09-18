resource "aws_vpc" "virtual_network" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.virtual_network.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "lb_public_subnet" {
  vpc_id = aws_vpc.virtual_network.id
  cidr_block = var.lb_public_subnet_cidr
  availability_zone = "ap-south-1b"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.virtual_network.id
  cidr_block = var.private_subnet_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.virtual_network.id
}

resource "aws_route_table" "routetable" {
    vpc_id = aws_vpc.virtual_network.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.routetable.id
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "private_nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet.id
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_nat" {
    vpc_id = aws_vpc.virtual_network.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.private_nat.id
    }
}

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private_nat.id
  subnet_id = aws_subnet.private_subnet.id
}

output "vpc_id"{
    value = aws_vpc.virtual_network.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "lb_public_subnet" {
  value = aws_subnet.lb_public_subnet.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "public_ip" {
    value = aws_eip.nat_eip.public_ip
}