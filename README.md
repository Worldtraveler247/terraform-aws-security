# Terraform AWS Security Foundations

Terraform configurations to build secure AWS infrastructure from the ground up.
Focused on security best practices: least privilege, encryption, logging, and auditing.

## What This Builds
- S3 buckets with encryption, versioning, and public access blocked
- IAM roles and policies following least-privilege principle
- CloudTrail for audit logging (who did what, when)
- VPC with secure defaults

## Skills Demonstrated
- Terraform (Infrastructure as Code)
- AWS security hardening
- IAM least-privilege design
- Encryption at rest and in transit
- Cloud audit logging

## Requirements
- Terraform v1.0+
- AWS CLI configured (`aws configure`)
- AWS account (free tier works for all examples)

## Usage
```bash
# 1. Initialize Terraform
terraform init

# 2. Preview what will be created
terraform plan

# 3. Build it
terraform apply

# 4. Tear it all down when done (avoid AWS charges)
terraform destroy
```

## Project Structure
```
terraform-aws-security/
├── main.tf              # Root configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── providers.tf         # AWS provider config
├── modules/
│   └── s3-secure/       # Reusable secure S3 module
└── examples/            # Example configurations
```

## Author
Ed | Cloud Security Engineer in Progress
GitHub: Worldtraveler247
