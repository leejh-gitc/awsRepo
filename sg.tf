# Security Group
resource "aws_security_group" "lb_sg" {
        name    = "lb_sg"
        vpc_id  = aws_vpc.terra.id
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
}
        ingress {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                        }
        egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "pbu_ec2_sg" {
        name    = "pbu_ec2_sg"
        vpc_id  = aws_vpc.terra.id
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["58.150.221.203/32"]
}
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["13.209.1.0/24"]
                        }
        egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "pri_ec2_sg" {
        name    = "pri_ec2_sg"
        vpc_id  = aws_vpc.terra.id
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                security_groups = [aws_security_group.lb_sg.id]
}
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                security_groups = [aws_security_group.pbu_ec2_sg.id]
                        }
        egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	  }
}
