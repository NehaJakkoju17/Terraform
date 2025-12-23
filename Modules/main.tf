provider "aws" {
  region = "us-east-1"
}

module "ec2_insatance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0b4bc1e90f30ca1ec"
    instance_type_value = "t3.micro"
    subnet_value = "subnet-06f1f4405687629b2"
}