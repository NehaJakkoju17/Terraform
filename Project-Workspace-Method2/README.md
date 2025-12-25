Terraform EC2 Deployment Using Workspaces
📌 Project Overview

This Terraform project provisions an AWS EC2 instance using Terraform modules and workspaces.
The EC2 instance type and environment tags change automatically based on the active Terraform workspace (dev, staging, or prod).

This approach helps manage multiple environments using a single codebase.

📂 Project Structure
.
├── main.tf
├── terraform.tfvars
└── modules
    └── ec2_instance
        └── workspace
            └── main.tf

🧩 Module: EC2 Instance
📍 Path

modules/ec2_instance/workspace/main.tf

🔹 Purpose

Creates an EC2 instance with environment-specific tags.

🔹 Module Code
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
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    name = "workspace-${var.env}"
    env  = var.env
  }
}

🌍 Root Configuration
📍 Root main.tf

This file:

Defines environment-specific instance types

Uses terraform.workspace to decide which values to use

Calls the EC2 module

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
    dev     = "t2.micro"
    staging = "t2.medium"
    prod    = "t2.xlarge"
  }
}

variable "env" {
  description = "Environment"
  type = map(string)
  default = {
    dev     = "dev"
    staging = "staging"
    prod    = "prod"
  }
}

module "workspace_ec2" {
  source        = "./modules/ec2_instance_workspace"
  ami           = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  env           = lookup(var.env, terraform.workspace, "dev")
}

⚙️ Variable File
terraform.tfvars
ami = "ami-0157af9aea2eef346"


ℹ️ Only the AMI is defined here.
Instance type and environment are selected automatically using Terraform workspaces.

🚀 How to Deploy
1️⃣ Initialize Terraform
terraform init

2️⃣ Create Workspaces (one-time)
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

3️⃣ Deploy to DEV
terraform workspace select dev
terraform apply


➡️ EC2 type: t2.micro
➡️ Tags:

name = workspace-dev
env  = dev

4️⃣ Deploy to PROD
terraform workspace select prod
terraform apply


➡️ EC2 type: t2.xlarge
➡️ Tags:

name = workspace-prod
env  = prod

🏷️ Environment Mapping
Workspace	Instance Type	Tag (env)
dev	t2.micro	dev
staging	t2.medium	staging
prod	t2.xlarge	prod
🧹 Cleanup

To destroy resources for a specific environment:

terraform workspace select dev
terraform destroy

✅ Key Terraform Concepts Used

Terraform Modules

Terraform Workspaces

lookup() function

Environment-based deployments

AWS EC2 provisioning

Reusable Infrastructure as Code