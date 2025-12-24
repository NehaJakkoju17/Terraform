provider "aws" {
  region = "us-east-1"
}
variable "cidr" {
 default = "10.0.0.0/16"
}
resource "aws_key_pair" "provisioner_keypair" {
  key_name = "provisioner_keypair"
  public_key = file("D:/2025/keypair.pub")
}
resource "aws_vpc" "provisioner_vpc" {
  cidr_block = var.cidr
}
resource "aws_subnet" "provisioner_subnet" {
  vpc_id = aws_vpc.provisioner_vpc.id
  cidr_block = "10.0.1.0/24"
}
resource "aws_internet_gateway" "provisioner_igw" {
  vpc_id = aws_vpc.provisioner_vpc.id
}
resource "aws_route_table" "provisioner_rt" {
  vpc_id = aws_vpc.provisioner_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.provisioner_igw.id
  }
}
resource "aws_route_table_association" "provisioner_rta" {
    subnet_id = aws_subnet.provisioner_subnet.id
    route_table_id = aws_route_table.provisioner_rt.id  
}
resource "aws_security_group" "provisioner_sg" {
    vpc_id = aws_vpc.provisioner_vpc.id
    description = "Allow all inbound traffic"
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {name = "provisioner_sg"}
}
resource "aws_instance" "provisioner_ec2" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = "t2.micro"
  key_name = aws_key_pair.provisioner_keypair.key_name
  subnet_id = aws_subnet.provisioner_subnet.id
  vpc_security_group_ids = [aws_security_group.provisioner_sg.id]
  associate_public_ip_address = true

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file("D:/2025/keypair")
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
    
  }
  provisioner "remote-exec" {
    inline = [ 
        "echo 'Hello from the remote instance'",
        "sudo apt update -y",
        "sudo apt-get install -y python3-pip",
        "cd /home/ubuntu",
        "sudo apt install python3-flask",
        "nohup sudo python3 /home/ubuntu/app.py > app.log 2>&1 &",
     ]
  }
}