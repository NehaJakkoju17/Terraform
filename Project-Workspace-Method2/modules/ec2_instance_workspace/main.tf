provider "aws" {
  region = "us-east-1"
}
variable "ami" {
  description = "AMI"
}
variable "instance_type" {
  description = "instance type"
}
variable "env" {
  description = "env"
}

resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {name = "workspace-${var.env}",env = var.env}
}