# Step-by-step guide to run project and capture required screenshots

Prerequisites:
- Terraform installed (v1.0+)
- AWS CLI configured (aws configure)
- An AWS account (free tier may be used)
- SSH key pair on your laptop (~/.ssh/id_rsa and id_rsa.pub)

A. Terraform (local state)
1. Open terminal and navigate to terraform directory:
   cd terraform

2. Initialize Terraform:
   terraform init

3. Validate:
   terraform validate

4. Plan (use your own tfvars):
   terraform plan -var-file=terraform.tfvars

5. Apply:
   terraform apply -var-file=terraform.tfvars

6. Verify in AWS Console:
   - S3: confirm buckets exist and versioning status
   - EC2: check instance and Public IP
   - RDS: check instance status (it may take several minutes)

Screenshots to capture for submission:
- S3 Buckets page showing the created buckets and versioning enabled.
- EC2 console showing instance with Public IP.
- RDS console showing the DB instance status and endpoint.
- Terminal output: `terraform apply` showing created resources (you can screenshot the terminal).
- CloudFormation stack events and output pages after creating stacks.

B. CloudFormation (Console or CLI)
1. In AWS Console -> CloudFormation -> Create stack -> Upload template (choose from cloudformation/*.yml)
2. Provide parameters (KeyName, AmiId, etc as requested)
3. Create stack and wait for CREATE_COMPLETE
4. Capture:
   - CloudFormation stack outputs (Public IP, Bucket names, DB endpoint)
   - CloudFormation template view and events (screenshot)

C. Cleaning up (important to avoid charges)
- Terraform:
  terraform destroy -var-file=terraform.tfvars
- CloudFormation:
  aws cloudformation delete-stack --stack-name <stack-name>

