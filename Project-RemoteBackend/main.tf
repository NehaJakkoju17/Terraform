provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nehainsatnce" {
  instance_type = "t2.micro"
  ami = "ami-0157af9aea2eef346"
}
resource "aws_s3_bucket" "remotebackend" {
  bucket = "terraform-neha-rb"
  region = "us-east-1"

}
