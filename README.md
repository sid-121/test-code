# Http Service on AWS EC2 with Terraform


# Overview
This repository contains Terraform configuration files to provision an EC2 instance running a Http service on AWS. The setup includes the creation of necessary AWS resources such as EC2 instances, security groups, IAM roles, and key pairs.

Design Decisions
# 1.Infrastructure:
  - EC2 Instance: Uses a small instance type (t2.micro) to minimize cost while providing sufficient resources for running a basic Flask application.
  - AMI: Configured to use an Ubuntu-based AMI to leverage Ubuntu's extensive community support and package availability.
  - Security Group: Allows inbound traffic on port 5000 to enable access to the Flask application from the internet.

# 2.User Data Script:
  - Installs necessary packages (python3-pip, git) and sets up the Flask application by cloning the repository and running it. 
  - Uses apt-get for package management as the instance is based on Ubuntu.


# 3.IAM Role and Instance Profile: 
  - Attaches an IAM role to the instance to manage permissions securely. 
  - Assumes an existing IAM role with necessary policies.


# Assumptions
  - AWS Credentials: It is assumed that AWS credentials are configured in the local environment or via the default profile. The credentials are used to authenticate Terraform actions.
  - Key Pair: Ensure the key pair name specified in Terraform exists in AWS or is managed by Terraform.

# Application Repository:
  - The application code is cloned from https://github.com/sid-121/exam-code.git. Ensure this repository is accessible and contains the app.py script.
  - Region and AMI:The specified AMI ID (ami-0814efd714b06daf3) is a placeholder. Replace it with a valid Ubuntu AMI ID for your AWS region.

# Prerequisites
  - Terraform: Install Terraform on your local machine. Follow the Terraform installation guide if needed.
  - AWS CLI: Install and configure the AWS CLI. Follow the AWS CLI installation guide if needed.
    
# Configuration
Clone the Repository:
 - git clone https://github.com/your-username/your-repo.git
 - cd your-repo
   
Update Configuration: Edit the ec2.tf file to replace the ami ID with a valid Ubuntu AMI ID for your region.
Ensure the aws_key_pair resource is correct.


# Initialize Terraform:
 - terraform init  
 - terraform plan
 - terraform apply

Confirm the action when prompted.

# Outputs
Public IP: The public IP of the EC2 instance will be displayed upon successful Terraform apply. Use this IP to access your Http Service in a web browser.
  example: http://ec2-ip:5000/list-bucket-content/dir1

Cleaning Up
To destroy all resources created by Terraform:

terraform destroy
Troubleshooting
InvalidKeyPair.NotFound: Ensure the key pair name matches exactly with the key pair in your AWS account or create a new key pair as described in the ec2.tf file.
Instance Not Accessible: Verify that security group rules are correct and that the instance is running. Ensure that the Flask application is running and listening on the correct port.
