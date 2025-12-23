resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr
  
}

resource "aws_subnet" "my_subnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1e"
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "my_subnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1f"
    map_public_ip_on_launch = true
  
}

resource "aws_internet_gateway" "my_internetgateway" {
    vpc_id = aws_vpc.my_vpc.id
  
}

resource "aws_route_table" "my_routetable" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internetgateway.id
  }

}

resource "aws_route_table_association" "rta1"{
    subnet_id = aws_subnet.my_subnet1.id
    route_table_id = aws_route_table.my_routetable.id
}
resource "aws_route_table_association" "rta2"{
    subnet_id = aws_subnet.my_subnet2.id
    route_table_id = aws_route_table.my_routetable.id
}

resource "aws_security_group" "mysg"{
    name = "mysg"
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        description = "Http from vpc"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        name = "web-sg"
    }
}
resource "aws_s3_bucket" "mybucket" {
  bucket = "nehajakkojus3bucket"

}
resource "aws_instance" "webserver1" {
  ami                    = "ami-0157af9aea2eef346"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.my_subnet1.id
  user_data              = filebase64("userdata1.sh")
}

resource "aws_instance" "webserver2" {
  ami                    = "ami-0157af9aea2eef346"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.my_subnet2.id
  user_data              = filebase64("userdata2.sh")
}
resource "aws_alb" "alb" {
    name = "myalb"
    internal = false
    security_groups = [aws_security_group.mysg.id]
    subnets = [aws_subnet.my_subnet1.id,aws_subnet.my_subnet2.id]
    tags = {
      name = "web"
    }
}

resource "aws_alb_target_group" "albtrgt" {
  name = "myTG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.my_vpc.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
    target_group_arn = aws_alb_target_group.albtrgt.arn
    target_id = aws_instance.webserver1.id
    port = 80  
}

resource "aws_lb_target_group_attachment" "attach2" {
    target_group_arn = aws_alb_target_group.albtrgt.arn
    target_id = aws_instance.webserver2.id
    port = 80  
}

resource "aws_alb_listener" "listener" {
    load_balancer_arn = aws_alb.alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_alb_target_group.albtrgt.arn
      type = "forward"
    }
  
}

output "lbarn" {
  value = aws_alb.alb.dns_name
}
