
# EC2
resource "aws_instance" "ec2-bastion" {
        ami = "ami-0bd7691bf6470fe9c"
        instance_type = "t2.micro"
        subnet_id = aws_subnet.pub-subnet1.id
        associate_public_ip_address = "true"
        key_name = "UWS_Test"
        vpc_security_group_ids = [aws_security_group.pbu_ec2_sg.id]
}

resource "aws_instance" "ec2-1" {
        ami = "ami-0bd7691bf6470fe9c"
        instance_type = "t2.micro"
        subnet_id = aws_subnet.pri-subnet1.id
        key_name = "UWS_Test"
        vpc_security_group_ids = [aws_security_group.pri_ec2_sg.id]
}

resource "aws_instance" "ec2-2" {
        ami = "ami-0bd7691bf6470fe9c"
        instance_type = "t2.micro"
        subnet_id = aws_subnet.pri-subnet2.id
        key_name = "UWS_Test"
        vpc_security_group_ids = [aws_security_group.pri_ec2_sg.id]
}

# TargetGroup
resource "aws_lb_target_group" "tg" {
        name = "test-tg"
        port = 80
        protocol = "HTTP"
        vpc_id = aws_vpc.terra.id
}

# TargetGroup Attachment
resource "aws_lb_target_group_attachment" "tg1" {
        target_group_arn = aws_lb_target_group.tg.arn
        target_id = aws_instance.ec2-1.id
        port = 80
}

resource "aws_lb_target_group_attachment" "tg2" {
        target_group_arn = aws_lb_target_group.tg.arn
        target_id = aws_instance.ec2-2.id
        port = 80
}

# Application Load Balancer
resource "aws_lb" "test-lb" {
  name               = "test-lb"
  internal           = false
    load_balancer_type = "application"
        subnets            = [aws_subnet.pub-subnet1.id, aws_subnet.pub-subnet2.id]
        security_groups = [aws_security_group.lb_sg.id]
}

resource "aws_lb_listener" "test-les" {
        load_balancer_arn = aws_lb.test-lb.arn
        port = "80"
        protocol = "HTTP"

        default_action {
        type    = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
        }
}
