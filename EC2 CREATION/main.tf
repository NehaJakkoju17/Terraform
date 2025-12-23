provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "my_ec2" {
    ami = "ami-0157af9aea2eef346"
    instance_type = "t3.micro"
    key_name = "Terraform_linux"
    subnet_id = "subnet-0342a74cfd54d79e2"

  
}