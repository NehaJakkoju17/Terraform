Terraform Projects Repository

Welcome to my Terraform Projects repository! 🌱

This repository contains multiple hands-on Terraform projects designed for learners and enthusiasts who want to explore AWS infrastructure automation. Each project demonstrates how to create, configure, and manage AWS resources using Terraform.

Project 1: Simple EC2 Instance

Purpose: Launch a basic EC2 instance in a specific subnet.

What it does:

Uses AWS provider (us-east-1)

Launches an EC2 instance (t3.micro) with a specified AMI and key pair

Key files:

main.tf – Contains the EC2 resource configuration

Learnings:

How to create a basic EC2 instance

How to specify subnet, AMI, and instance type

Project 2: EC2 with Security Group

Purpose: Deploy an EC2 instance with a custom security group.

What it does:

Creates a Security Group allowing SSH (22) and HTTP (80)

Launches an EC2 instance attached to the security group

Outputs the instance ID, public IP, and Security Group ID

Key files:

main.tf – Resources (EC2 & Security Group)

variables.tf – Inputs for AMI, instance type, SG name, description

terraform.tfvars – Values for variables

outputs.tf – Shows instance ID, public IP, SG ID

Learnings:

How to create and attach security groups to EC2

Using variables and outputs for flexible configuration

Project 3: EC2 with Variables and Outputs

Purpose: Launch a reusable EC2 instance with variables and outputs.

What it does:

Defines variables for AMI and instance type

Launches an EC2 instance using these variables

Outputs instance ID and public IP

Key files:

main.tf – EC2 resource

variables.tf – Define input parameters

terraform.tfvars – Actual values

outputs.tf – Display important instance info

Learnings:

Passing variables to resources

Using outputs to get instance details

Project 4: VPC, Subnets, Security Group, EC2, and ALB

Purpose: Build a complete networking setup with VPC, subnets, EC2, Security Group, and Application Load Balancer (ALB).

What it does:

Creates a VPC with two public subnets

Creates Internet Gateway and route tables

Configures Security Group for SSH and HTTP

Launches two EC2 instances

Deploys an ALB with a target group and listener

Outputs VPC ID, subnet IDs, Security Group ID, EC2 public IPs, ALB DNS

Key files:

main.tf – Complete infra setup

variables.tf – VPC, subnet, SG, and instance variables

outputs.tf – Outputs for all important resources

Learnings:

VPC and subnet creation

Route tables and Internet Gateway setup

Multi-AZ EC2 deployment

Application Load Balancer configuration

Project 5: VPC, Subnets, S3 Bucket, EC2, and ALB with User Data

Purpose: Deploy web servers with automated setup via user data.

What it does:

Creates VPC, two subnets, Internet Gateway, route tables

Security Group for HTTP and SSH

Deploys two EC2 instances with Apache installed using user data scripts

Creates S3 bucket for project files

Configures ALB and target groups

Outputs ALB DNS

Key files:

main.tf – Full infrastructure

provider.tf – AWS provider setup

variables.tf – VPC CIDR

userdata1.sh & userdata2.sh – Scripts to install Apache and generate simple HTML pages

Learnings:

Automating server setup with user data

Deploying web applications on EC2

Integrating S3 with EC2

Load balancing with ALB

Project 6: Reusable EC2 Module

Purpose: Demonstrate Terraform modules for reusability.

What it does:

Uses a local module (modules/ec2_instance) to create EC2 instance

Passes AMI, instance type, and subnet as module variables

Outputs the public IP of the EC2 instance

Key files:

main.tf – Calls EC2 module

modules/ec2_instance/ – Contains main.tf, variables.tf, outputs.tf

Learnings:

How to create reusable Terraform modules

Passing variables to modules

Getting outputs from modules

Key Takeaways from All Projects

Learn how to define and use AWS provider in Terraform

Understand EC2, Security Groups, VPC, Subnets, IGW, Route Tables

Work with ALB and Target Groups

Use variables, outputs, and tfvars for flexibility

Implement user data scripts to automate server setup

Create reusable modules to avoid code duplication

Getting Started

Clone this repository.

Navigate to the project folder you want to deploy.

Initialize Terraform:

terraform init


Preview the changes:

terraform plan


Apply the infrastructure:

terraform apply


Destroy resources after testing:

terraform destroy
