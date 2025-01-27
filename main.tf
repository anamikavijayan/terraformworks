provider "aws" {
  region = "ap-south-1" # Replace with your preferred region
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-test-teerraform-bkt10" # Replace with a globally unique name

  tags = {
    Name        = "My Public Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.public_bucket.arn,
          "${aws_s3_bucket.public_bucket.arn}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access_block]
}


