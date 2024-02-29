
locals {
  s3_origin_id = "S3-${var.bucket_name}"
  s3_domain_name = aws_s3_bucket.web.bucket_regional_domain_name
}

resource "aws_cloudfront_distribution" "web" {
  depends_on = [aws_s3_bucket.web]
  enabled = true
  origin {
    domain_name = local.s3_domain_name
    origin_id   = local.s3_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }
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
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = var.cloudfront_price_class
}