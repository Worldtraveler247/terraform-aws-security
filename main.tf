# ============================================================
# Terraform AWS Security Foundations
# Author: Ed (Worldtraveler247)
# Description: Secure AWS infrastructure baseline
# ============================================================

# ---- Secure S3 Bucket ----

resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# Block ALL public access — critical security setting
resource "aws_s3_bucket_public_access_block" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning — recover from accidental deletes
resource "aws_s3_bucket_versioning" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (AES-256)
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Enforce HTTPS only — no unencrypted transfers
resource "aws_s3_bucket_policy" "enforce_https" {
  bucket = aws_s3_bucket.secure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyHTTP"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.secure_bucket.arn,
          "${aws_s3_bucket.secure_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# ---- IAM Role with Least Privilege ----

# Role that can only read from the secure bucket — nothing else
resource "aws_iam_role" "s3_read_only" {
  name = "${var.project_name}-s3-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_read_only" {
  name = "${var.project_name}-s3-read-policy"
  role = aws_iam_role.s3_read_only.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Least privilege: read only, specific bucket only
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.secure_bucket.arn,
          "${aws_s3_bucket.secure_bucket.arn}/*"
        ]
      }
    ]
  })
}
