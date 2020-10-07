#AWS Subnet tf 
provider "aws" {
  region     = "ap-northeast-2"
  access_key = var.uws-access
  secret_key = var.uws-secret
  }

#VPC 
resource "aws_vpc" "main" {
    cidr_block		 = "192.168.0.0/16"
	instance_tenancy = "default"
}

resource "aws_subnet" "subnet1" {
	vpc_id     = "${aws_vpc.main.id}"
	cidr_block = "192.168.1.0/24"
	availability_zone = "ap-northeast-2a"
	tags = {
		Name = "Subunet1"
	}
	
}


#Subnet
resource "aws_subnet" "subnet2" {
	vpc_id     = "${aws_vpc.main.id}"
	cidr_block = "192.168.2.0/24"
	availability_zone = "ap-northeast-2b"

	tags = {
		Name = "Subunet2"
	}
}

resource "aws_subnet" "subnet3" {
	vpc_id     = "${aws_vpc.main.id}"
	cidr_block = "192.168.3.0/24"
	availability_zone = "ap-northeast-2c"

	tags = {
		Name = "Subunet3"
	}
}

resource "aws_subnet" "subnet4" {
	vpc_id     = "${aws_vpc.main.id}"
	cidr_block = "192.168.4.0/24"
	availability_zone = "ap-northeast-2d"

	tags = {
		Name = "Subunet4"
	}
}
