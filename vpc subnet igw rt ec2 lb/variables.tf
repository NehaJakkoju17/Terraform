variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default = "10.0.0.0/16"
}
variable "subnet1_cidr" {
  description  = "Subnet CIDR block"
  default = "10.0.1.0/24"
}
variable "subnet2_cidr" {
  description = "Subnet 2 CIDR Block"
  default = "10.0.2.0/24"
}
variable "sg_name" {
  description = "Security group name"
  default = "allow-ssh-http"
}
variable "sg_description" {
  description = "Security group description"
  default = "Allow SHH and HTTP"
}
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0157af9aea2eef346" # Amazon Linux 2
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}
