# PROG8870 - AWS Infrastructure Automation with Terraform and CloudFormation

This repository contains a complete project skeleton for the course final project:
**AWS Infrastructure Automation with Terraform and CloudFormation**.

## What is included
- Terraform configuration (terraform/) to create:
  - VPC, public and private subnets (using community module)
  - EC2 instance with SSH access
  - 4 Private S3 buckets with optional versioning
  - MySQL RDS instance (db.t3.micro)
- CloudFormation templates (cloudformation/) for:
  - S3 buckets (3) with PublicAccessBlockConfiguration and versioning enabled
  - EC2 with VPC, IGW, and outputs for PublicIP
  - RDS MySQL instance (public for project demo)
- Instructions to run and capture screenshots for the assignment.
- A simple PowerPoint (presentation.pptx) to use in your demo.

## Important notes
- **DO NOT** commit real secrets (passwords, private keys) to GitHub.
- terraform.tfvars contains example values. Replace them with your own when running locally.
- CloudFormation templates include placeholder subnet IDs for RDS - replace with real subnet IDs or deploy using AWS Console guided flow.

## How to run (high level)
1. Install Terraform and AWS CLI and configure AWS credentials (`aws configure`).
2. Change to `terraform/` folder:
   ```
   cd terraform
   terraform init
   terraform plan -var-file=terraform.tfvars
   terraform apply -var-file=terraform.tfvars
   ```
3. For CloudFormation, use AWS Console or CLI:
   ```
   aws cloudformation create-stack --stack-name prog8870-s3 --template-body file://cloudformation/s3.yml --capabilities CAPABILITY_NAMED_IAM
   ```
4. Follow the README in the repo for more detailed step-by-step instructions.

## Files
See the project folder structure in the repo.

