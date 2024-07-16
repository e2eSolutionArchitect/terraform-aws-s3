# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure regio"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}



# -------------------------------------------
# S3 Variables
# -------------------------------------------

variable "s3_bucket_name" {
  description = "s3 bucket names"
  type        = string
  default     = null
}

variable "s3_versioning" {
  description = "s3 versioning"
  type        = string
  default     = "Enabled"
}

variable "enable_lifecycle_rule" {
  description = "s3 life cycle"
  type        = bool
  default     = false
}

variable "acl" {
  description = "s3 bucket ACL type"
  type        = string
  default     = "private" # ["private" "public-read" "public-read-write" "authenticated-read" "aws-exec-read" "log-delivery-write"]
}

variable "enable_force_destroy" {
  description = "enable_force_destroy"
  type        = bool
  default     = false
}

variable "control_object_ownership" {
  description = "s3 control_object_ownership"
  type        = string
  default     = "Enabled"
}

variable "create_folder" {
  description = "s3 create_folder"
  type        = bool
  default     = false
}

variable "folder_name" {
  description = "s3 folder_name"
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "kms key is_enabled"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "kms key enable_key_rotation"
  type        = bool
  default     = true
}

variable "attach_policy" {
  description = "s3 attach_policy"
  type        = bool
  default     = false
}

variable "policy_statements" {
  description = "s3 policy_statements"
  type        = string
  default     = ""
}

variable "lambda_notifications" {
  description = "s3 lambda_notifications"
  type        = any #map(string)
  #default     = {}
}

variable "is_enabled_eventbridge" {
  description = "If eventbridge is enabled for S3 trigger"
  type        = bool
  default     = false
}

variable "iam_policy_identifier" {
  type        = list(string)
  description = "iam policy identifier"
}


variable "source_account" {
  description = "source_account AWS account no"
  type        = string
  default     = ""
}

