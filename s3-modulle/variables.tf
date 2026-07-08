variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "my-app-bucket"
}

# variable "versioning_enabled" {
#   description = "Enable versioning on the S3 bucket"
#   type        = bool
#   default     = true
# }

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"
}

# variable "block_public_acls" {
#   description = "Block public ACLs"
#   type        = bool
#   default     = true
# }

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets"
  type        = bool
  default     = true
}
