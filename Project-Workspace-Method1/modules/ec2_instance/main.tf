provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "AMI value"
}
variable "instance_type" {
  description = "Instance type"
}
variable "env" {
  description = "Environment"
}

resource "aws_instance" "workspace_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {name = "workspace_ec2_${var.env}",env = var.env}
}
