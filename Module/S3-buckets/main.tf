# S3 bucket policy that allows only CloudFront (via OAI) to read objects from the bucket
# This keeps the bucket private and only accessible through CloudFront
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.oai_iam_arn
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

# Create the S3 bucket for hosting the static website
# The bucket name is passed in as a variable from the root module. 
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = true
}

# Configure the S3 bucket for static website hosting
# Sets the index and error documents for the website
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}


