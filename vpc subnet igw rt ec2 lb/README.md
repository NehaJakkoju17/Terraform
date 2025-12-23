Project 3: AWS VPC with EC2 and Application Load Balancer (Terraform)
Overview

This project demonstrates how to build a complete AWS infrastructure using Terraform, without using modules.
The setup includes a custom VPC, public subnets, EC2 instances, and an Application Load Balancer to distribute traffic across instances.

The main goal of this project was to understand resource dependencies, networking concepts, and real-world Terraform errors by building everything from scratch and fixing issues along the way.
------------------------------------
Architecture

The infrastructure includes:

Custom VPC

Two public subnets in different availability zones

Internet Gateway

Public route table and associations

Security group

Two EC2 instances (one in each subnet)

Application Load Balancer

Target group and listener

Traffic flow:

Internet → ALB → EC2 instances (in different AZs)
--------------------------------------------------
Tools & Technologies Used

AWS

Terraform

EC2

VPC

Application Load Balancer
------------------------------------------------------
Terraform Resources Created

aws_vpc

aws_subnet

aws_internet_gateway

aws_route_table

aws_route_table_association

aws_security_group

aws_instance

aws_alb

aws_alb_target_group

aws_alb_listener
------------------------------------------------------
Key Challenges Faced & Fixes
1. Security Group and Subnet Network Error

Error:

Security group and subnet belong to different networks


Root Cause:
The security group was not explicitly associated with the custom VPC, so AWS tried to use the default VPC security group behavior.

Fix:
Attached the security group correctly and ensured all resources referenced the same VPC.

2. ALB Security Group Error

Error:

InvalidConfigurationRequest: One or more security groups are invalid


Root Cause:
The ALB security group must belong to the same VPC as the subnets.

Fix:
Used the same VPC-based security group for both EC2 instances and the ALB.

3. Dependency & Order of Creation

Some resources failed initially due to missing or incorrect dependencies.

Learning:
Terraform automatically handles dependencies only if references are correct. Explicit references are very important.
---------------------------------------------------------------------------
What I Learned from This Project

How VPC, subnets, and security groups are tightly connected

Why ALB, EC2, and subnets must always belong to the same VPC

How to debug Terraform AWS errors instead of guessing

Importance of reading AWS error messages carefully

Confidence in building infrastructure without Terraform modules
-------------------------------------------------------------------------
Why No Modules Were Used

This project was intentionally built without modules to strengthen core Terraform concepts and understand how AWS resources interact internally.
-------------------------------------------------------------------
How to Use
terraform init
terraform plan
terraform apply
---------------------------------------------------------------
Final Notes

This project was built by fixing real errors and understanding why they happened.
It helped me gain confidence in AWS networking and Terraform, and it reflects real-world troubleshooting rather than a perfect tutorial-based setup.

