Terraform EC2 Workspace-Based Deployment
📌 Overview

This project uses Terraform modules and workspaces to create an EC2 instance in AWS for different environments like dev, staging, and prod.

A reusable EC2 module is created.

Environment-specific values are managed using Terraform workspaces and .tfvars files.

EC2 instances are tagged dynamically based on the environment.

📂 Project Structure
.
├── main.tf
├── dev.tfvars
├── prod.tfvars
├── stage.tfvars
└── modules
    └── ec2_instance
        └── main.tf

📦 Module: modules/ec2_instance
Purpose

This module creates a single EC2 instance with environment-based tags.

modules/ec2_instance/main.tf
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
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    name = "workspace_ec2_${var.env}"
    env  = var.env
  }
}

🌍 Root Configuration
Root main.tf

This file:

Defines variables

Calls the EC2 module

Uses terraform.workspace to decide the environment dynamically

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
  source        = "./modules/ec2_instance"
  ami           = var.ami
  instance_type = var.instance_type
  env           = terraform.workspace
}

⚙️ Environment Variable Files
dev.tfvars
ami           = "ami-0157af9aea2eef346"
instance_type = "t2.micro"
env           = "dev"

prod.tfvars
ami           = "ami-0157af9aea2eef346"
instance_type = "t2.xlarge"
env           = "prod"


ℹ️ Note:
Even though env is defined in .tfvars, the actual environment tag comes from the Terraform workspace.

🚀 How to Deploy
1️⃣ Initialize Terraform
terraform init

2️⃣ Create Workspaces (only once)
terraform workspace new dev
terraform workspace new prod
terraform workspace new staging

3️⃣ Deploy to DEV
terraform workspace select dev
terraform apply -var-file="dev.tfvars"

4️⃣ Deploy to PROD
terraform workspace select prod
terraform apply -var-file="prod.tfvars"

🏷️ Tags Created on EC2

Each EC2 instance will have tags like:

name = workspace_ec2_dev
env  = dev


or

name = workspace_ec2_prod
env  = prod

✅ Key Concepts Used

Terraform Modules

Terraform Workspaces

Environment-based deployments

Reusable infrastructure

AWS EC2 provisioning

🧹 Cleanup

To destroy resources for a specific environment:

terraform workspace select dev
terraform destroy -var-file="dev.tfvars"