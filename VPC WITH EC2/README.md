Project 4: VPC, ALB, and Web Servers (End-to-End Project)

What I built

Custom VPC with CIDR block

Two public subnets across different availability zones

Internet Gateway and Route Table

Security Group for web access

Two EC2 web servers with Apache installed using user_data

Application Load Balancer with Target Group and Listener

S3 bucket creation

AWS Services Used

VPC

Subnets

Internet Gateway

Route Tables

Security Groups

EC2

Application Load Balancer

Target Groups

S3

Key Learnings

End-to-end infrastructure provisioning using Terraform

Understanding VPC networking concepts

Debugging real AWS errors (subnet and security group mismatches)

Importance of resource dependency and correct VPC association

Using user_data to configure instances automatically

Load balancing traffic across multiple EC2 instances

Challenges Faced & How I Fixed Them

Faced errors related to security groups and subnets belonging to different VPCs

Understood that ALB, EC2, subnets, and security groups must all be in the same VPC

Fixed issues by carefully checking resource references instead of hardcoding values

Learned to read Terraform and AWS error messages patiently and debug step by step

These issues helped me understand how AWS networking actually works in real projects.

How to Run These Projects
terraform init
terraform plan
terraform apply


Make sure:

AWS credentials are configured

Region matches the resources

Bucket names are globally unique

Why This Repository

