provider "aws" {
    region = "us-east-1"
  
}

resource "aws_security_group" "awssg" {
    name = var.sg_name
    description = var.sg_description
    vpc_id = "vpc-05732ef973beb5c52"

    ingress  {
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

}

resource "aws_instance" "ec2sg" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  vpc_security_group_ids = [aws_security_group.awssg.id]
  tags = {
    Name = "Terraform EC2"
  }
}


  
