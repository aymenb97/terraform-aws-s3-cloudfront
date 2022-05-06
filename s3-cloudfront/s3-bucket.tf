###################################
# S3 Bucket
###################################
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}

resource "random_pet" "bucket_name" {
  prefix = var.bucket_prefix
  length = 4
}
resource "aws_s3_bucket" "bucket" {
  bucket        = random_pet.bucket_name.id
  force_destroy = true
}
resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_policy" "_" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  count  = var.use_for_website ? 1 : 0
  bucket = aws_s3_bucket.bucket
  index_document {
    suffix = var.index_document_suffix
  }
  error_document {
    key = "error.html"
  }
}

data "aws_iam_policy_document" "bucket_policy_doc" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity._.iam_arn]

    }
    actions = [
      "s3:getObject"
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*"
    ]

  }

}

