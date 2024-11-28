# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "global" {
  description = "global config"
  type        = map(string)
  default = {
    "region"       = "us-east-1"
    "project"      = "project-name"
    "workloadname" = "workloadname"
    "desc"         = "desc"
    "createdby"    = "system"
    "orgunit"      = "OU001"
    "businessunit" = "BU001"
    "costcenter"   = "CC001"
    "environment"  = "dev"
    "owner"        = "owner@domain.com"
    supportcentre  = "support@domain.com"
  }
}

variable "aws_region" {
  description = "AWS infrastructure"
  type        = string
  default     = "us-east-1"
  validation {
    condition = anytrue([
      var.aws_region == "us-east-1",
      var.aws_region == "us-east-2"
    ])
    error_message = "Invalid AWS Region. Region must be US EAST 1 or US EAST 2"
  }
}



variable "env" {
  description = "Which environment the resource is deployed"
  type        = string
  default     = "dev"
  validation {
    condition = anytrue([
      var.env == "dev",
      var.env == "stg",
      var.env == "prod"
    ])
    error_message = "Invalid environment. Environment must be dev/stg/prod"
  }
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

# variable "iam_policy_identifier" {
#   type        = list(string)
#   description = "iam policy identifier"
# }

variable "folder_names" {
  type        = set(string)
  description = "folders in s3 bucket"
}


variable "source_account" {
  description = "source_account AWS account no"
  type        = string
  default     = ""
}


# --------------------------
# KMS
# --------------------------

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

variable "deletion_window_in_days" {
  description = "deletion_window_in_days"
  type        = number
  default     = 10
}

variable "kms_alias" {
  description = "kms_alias"
  type        = string
  default     = null
}
