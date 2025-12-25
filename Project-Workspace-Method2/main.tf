provider "aws" {
  region = "us-east-1"
}
variable "ami" {
  description = "AMI"
}
variable "instance_type" {
  description = "Instance type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "staging" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}
variable "env" {
  description = "Environment"
  type = map(string)
  default = {
    "dev" = "dev"
    "staging" = "staging"
    "prod" = "prod"
  }
}
module "workspace_ec2" {
  source = "./modules/ec2_instance_workspace"
  ami = var.ami
  instance_type = lookup(var.instance_type,terraform.workspace,"t2.micro")
  env = lookup(var.env,terraform.workspace,"dev")
}