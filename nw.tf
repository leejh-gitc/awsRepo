# VPC
resource "aws_vpc" "terra" {
        cidr_block = "10.0.0.0/16"
}

# Internet Gateway
resource "aws_internet_gateway" "intgw" {
        vpc_id = aws_vpc.terra.id
}

# Subnet
resource "aws_subnet" "pub-subnet1" {
        vpc_id = aws_vpc.terra.id
        cidr_block = "10.0.1.0/24"
        availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "pub-subnet2" {
        vpc_id = aws_vpc.terra.id
        cidr_block = "10.0.2.0/24"
        availability_zone = "ap-northeast-2c"
}

resource "aws_subnet" "pri-subnet1" {
        vpc_id = aws_vpc.terra.id
        cidr_block = "10.0.3.0/24"
        availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "pri-subnet2" {
        vpc_id = aws_vpc.terra.id
        cidr_block = "10.0.4.0/24"
        availability_zone = "ap-northeast-2c"
}

resource "aws_subnet" "pri-subnet3" {
        vpc_id = aws_vpc.terra.id
        cidr_block = "10.0.5.0/24"
        availability_zone = "ap-northeast-2c"
}


# Route Talbe
resource "aws_route_table" "publicrt" {
        vpc_id = aws_vpc.terra.id

        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.intgw.id
                }
}

resource "aws_route_table" "privatert" {
        vpc_id = aws_vpc.terra.id

        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = aws_nat_gateway.gw.id
                }
}

# Route Table association
resource "aws_route_table_association" "pub1" {
        subnet_id = aws_subnet.pub-subnet1.id
        route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "pub2" {
        subnet_id = aws_subnet.pub-subnet2.id
        route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "pri1" {
        subnet_id = aws_subnet.pri-subnet1.id
        route_table_id = aws_route_table.privatert.id
}

resource "aws_route_table_association" "pri2" {
        subnet_id = aws_subnet.pri-subnet2.id
        route_table_id = aws_route_table.privatert.id
}

# EIP
resource "aws_eip" "eipc" {
}

# NAT Gateway
resource "aws_nat_gateway" "gw" {
        allocation_id = aws_eip.eipc.id
        subnet_id = aws_subnet.pub-subnet2.id
}
