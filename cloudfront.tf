# Variables to identify bucket
locals {
  s3_origin_id = "S3-${var.bucket_name}"
  s3_domain_name = aws_s3_bucket.web.bucket_regional_domain_name
}
# Create CloudFront Origin Access Identity to access S3 bucket
resource aws_cloudfront_origin_access_identity "web" {
  comment = "Access-Identity-${var.bucket_name}"
}

 # Create CloudFront distribution
resource "aws_cloudfront_distribution" "web" {
  depends_on = [aws_s3_bucket.web]
  # Default root to index.html
  default_root_object = "index.html"
  enabled = true
  origin {
    domain_name = local.s3_domain_name
    origin_id   = local.s3_origin_id
    # S3 bucket origin configuration
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.web.cloudfront_access_identity_path
    }

  }
    # Caching configuration
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    # Cache duration
    min_ttl     = 60 # 1 minute
    default_ttl = 86400 # 24 hours
    max_ttl     = 604800 # 7 days
  }
    # global access
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  # Price class
  price_class = var.cloudfront_price_class
}