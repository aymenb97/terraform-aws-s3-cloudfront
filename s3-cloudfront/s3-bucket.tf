###################################
# S3 Bucket
###################################
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
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



resource "aws_s3_object" "static_website_files" {
  for_each     = fileset(var.path_to_files, "*")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  content_type = "text/html"
  source       = "${var.path_to_files}/${each.value}"
  etag         = filemd5("${var.path_to_files}/${each.value}")
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

