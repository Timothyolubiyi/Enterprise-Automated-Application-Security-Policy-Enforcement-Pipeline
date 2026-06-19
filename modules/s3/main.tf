resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name

  tags = {

    Name = var.bucket_name

  }

}

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {

    status = "Enabled"

  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {

    apply_server_side_encryption_by_default {

      kms_master_key_id = var.kms_key_arn

      sse_algorithm = "aws:kms"

    }

  }

}

resource "aws_s3_bucket_public_access_block" "block" {

  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true

  block_public_policy     = true

  ignore_public_acls      = true

  restrict_public_buckets = true

}

resource "aws_s3_bucket_policy" "cloudtrail_policy" {

  bucket = var.bucket_name

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "AWSCloudTrailAclCheck"

        Effect = "Allow"

        Principal = {

          Service = "cloudtrail.amazonaws.com"

        }

        Action = "s3:GetBucketAcl"

        Resource = "arn:aws:s3:::${var.bucket_name}"

      },

      {

        Sid = "AWSCloudTrailWrite"

        Effect = "Allow"

        Principal = {

          Service = "cloudtrail.amazonaws.com"

        }

        Action = "s3:PutObject"

        Resource = "arn:aws:s3:::${var.bucket_name}/AWSLogs/*"

      }

    ]

  })

}