variable "use_for_website" {
  description = "Specify either the website is used for a static website hosting or for files"
  type        = bool
  default     = false
}
variable "bucket_prefix" {
  description = "Specify the prefix for the bucket name"
  type        = string
  default     = "s3-cloudfront"

}
variable "index_document_suffix" {
  description = "Index document for static website"
  type        = string
  default     = "index.html"
}
variable "compress" {
  description = "Specify either cached objects are compressed or not"
  type        = bool
  default     = true

}
variable "min_ttl" {
  description = "Minimal TTL Value (in seconds)"
  default     = 0
}
variable "max_ttl" {
  description = "Minimal TTL Value (in seconds)"
  default     = 60 * 60
}

variable "default_ttl" {
  description = "Default TTL Value (in seconds)"
  default     = 5 * 60
}
