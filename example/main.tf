module "aws-s3-cloudfront" {
  source        = "../s3-cloudfront"
  path_to_files = "./static-website-files"
}
output "cloudfront_dns" {
  value = module.aws-s3-cloudfront.cloudfront_domain_name
}
