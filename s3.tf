
# Create S3 bucket
resource "aws_s3_bucket" "web" {
  bucket = "${var.bucket_name}"
  tags = {
    Name = "webpage"
  }
}

# ACL
resource "aws_s3_bucket_ownership_controls" "website_bucket" {
  bucket = aws_s3_bucket.web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Enable public access
resource "aws_s3_bucket_public_access_block" "web" {
  bucket = aws_s3_bucket.web.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}



# bucket policy (allow public read)
resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket.web, aws_cloudfront_origin_access_identity.web]
  bucket = aws_s3_bucket.web.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.web.id}"
        },
        Action   = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.web.bucket}/*"
        }
        ]
    })
}

# Web config
resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.web.id
  key = "index.html"
  source = "html/index.html"
  etag = "${filemd5("html/index.html")}"
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.web.id
  key = "error.html"
  source = "html/error.html"
  etag = "${filemd5("html/error.html")}"
  content_type = "text/html"
}