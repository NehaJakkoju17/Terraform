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

module "workspace_module" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = var.instance_type
  env = terraform.workspace
}