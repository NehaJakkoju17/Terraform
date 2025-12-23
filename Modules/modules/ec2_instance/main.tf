
provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "exampleec2" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_value
  
}