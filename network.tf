resource "aws_vpc" "jphacks" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "jphacks"
    }
}

resource "aws_subnet" "public-1a" {
    vpc_id                  = aws_vpc.jphacks.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "ap-northeast-1a"
}

resource "aws_internet_gateway" "public-1a-igw" {
    vpc_id = aws_vpc.jphacks.id
}

resource "aws_route_table" "public-1a" {
    vpc_id = aws_vpc.jphacks.id
}

resource "aws_route" "public-1a" {
    route_table_id = aws_route_table.public-1a.id
    gateway_id = aws_internet_gateway.public-1a-igw.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public-1a" {
    subnet_id = aws_subnet.public-1a.id
    route_table_id = aws_route_table.public-1a.id
}