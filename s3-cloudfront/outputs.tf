output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.web_distribution.domain_name
  description = "The domain name corresponding to the distribution"
}
output "cloudfront_arn" {
  value       = aws_cloudfront_distribution.web_distribution.arn
  description = "Get the ARN of the distribution"
}
output "S3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "Get the ARN of the bcuket"
}
