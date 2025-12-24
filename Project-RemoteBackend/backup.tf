terraform {
  backend "s3" {
    bucket = "terraform-neha-rb"
    region = "us-east-1"
    key = "neha/terraform.tfstate"
  }
}