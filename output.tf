output "website_url" {
  value = aws_s3_bucket.web.bucket_regional_domain_name
}