provider "aws" {
  region = var.region
}

resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr
  tags = {Name = "Project-VPC"}
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.new_vpc.id
  cidr_block = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {Name = "Public-Subnet-1"}
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.new_vpc.id
  cidr_block = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {Name = "Public-Subnet-2"}
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {Name = "Project-VPC-IGW"}
}

resource "aws_route_table" "public_rta" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {Name = "Public-Route-Table"}
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rta.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public_rta.id
}

resource "aws_security_group" "sg" {
  name = var.sg_name
  description = var.sg_description
  vpc_id = aws_vpc.new_vpc.id
  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {Name = "Project-VPC-SG"}
}

resource "aws_instance" "webec21" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = true
  tags = {Name = "webec21"}
}

resource "aws_instance" "webec22" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = true
  tags = {Name = "webec22"}
}
resource "aws_alb" "alb" {
  name = "projectvpc-alb"
  internal = false
  security_groups = [aws_security_group.sg.id]
  subnets = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  tags = {Name = "Project-VPC-alb"}
}
resource "aws_alb_target_group" "albtg" {
  name = "projectvpc-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.new_vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
  }
}
resource "aws_alb_target_group_attachment" "tgattach1" {
  target_group_arn = aws_alb_target_group.albtg.arn
  target_id = aws_instance.webec21.id
  port = 80
}
resource "aws_alb_target_group_attachment" "tgattach2" {
  target_group_arn = aws_alb_target_group.albtg.arn
  target_id = aws_instance.webec22.id
  port = 80
}
resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.albtg.arn
  }
}

output "lbarn" {
  value = aws_alb.alb.arn
}
