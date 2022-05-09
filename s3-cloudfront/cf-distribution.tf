###################################
# CloudFront Distribution
###################################
resource "aws_cloudfront_distribution" "web_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity._.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = var.index_document_suffix
  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.bucket.bucket
    viewer_protocol_policy = "redirect-to-https"
    compress               = var.compress
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

}
resource "aws_cloudfront_origin_access_identity" "_" {
  comment = "Access S3 Contents only through CloudWatch"

}
