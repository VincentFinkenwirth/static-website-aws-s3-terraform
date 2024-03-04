output "bucket_url" {
  value = aws_s3_bucket.web.bucket_regional_domain_name
}

output "website_cloudfront_url" {
  value = aws_cloudfront_distribution.web.domain_name
}
