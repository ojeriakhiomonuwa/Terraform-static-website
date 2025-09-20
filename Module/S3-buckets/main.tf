# S3 bucket to store website files (bucket name comes from root module)
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name  # Example: www.ojes.online
  force_destroy = true      # Allows Terraform to delete bucket even if it contains files
}

# Enable static website hosting on the S3 bucket
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"    # Default page when visiting the root URL
  }
  error_document {
    key = "error.html"       # Page shown for 404 errors
  }
}

# Disable public access blocks to allow website hosting
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false  # Allow public ACLs
  block_public_policy     = false  # Allow public bucket policies
  ignore_public_acls      = false  # Don't ignore public ACLs
  restrict_public_buckets = false  # Allow public bucket access
}

# Bucket policy to make all objects publicly readable
resource "aws_s3_bucket_policy" "public_read" {
  depends_on = [aws_s3_bucket_public_access_block.this]  # Wait for access blocks to be disabled
  
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"                              # Anyone can access
        Action    = "s3:GetObject"                   # Read-only access
        Resource  = "${aws_s3_bucket.this.arn}/*"   # All objects in bucket
      }
    ]
  })
}

# Upload all website files from local directory to S3
resource "aws_s3_object" "website_files" {
  depends_on = [aws_s3_bucket_website_configuration.this, aws_s3_bucket_public_access_block.this, aws_s3_bucket_policy.public_read]
  
  for_each = fileset("${path.root}/../2135_mini_finance", "**/*")  # Find all files in website directory
  
  bucket = aws_s3_bucket.this.id
  key    = each.value                                              # File path in S3 (e.g., css/style.css)
  source = "${path.root}/../2135_mini_finance/${each.value}"       # Local file path
  
  # Set correct MIME type so browsers handle files properly
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "woff" = "font/woff",
    "woff2" = "font/woff2",
    "txt"  = "text/plain"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
  
  etag = filemd5("${path.root}/../2135_mini_finance/${each.value}")  # File hash for change detection
}