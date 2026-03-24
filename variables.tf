variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "security-foundations"
}

variable "bucket_name" {
  description = "Name for the secure S3 bucket (must be globally unique)"
  type        = string
  default     = "worldtraveler247-secure-bucket"
}
