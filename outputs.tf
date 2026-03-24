output "bucket_name" {
  description = "Name of the secure S3 bucket"
  value       = aws_s3_bucket.secure_bucket.id
}

output "bucket_arn" {
  description = "ARN of the secure S3 bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}

output "iam_role_arn" {
  description = "ARN of the least-privilege IAM role"
  value       = aws_iam_role.s3_read_only.arn
}
