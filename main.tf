locals {
  create_bucket_acl = (var.acl != null && var.acl != "null")
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = var.enable_force_destroy
  tags          = merge({ "ResourceName" = var.s3_bucket_name }, var.tags)
}

resource "aws_s3_object" "folder" {
  count                  = var.create_folder ? 1 : 0
  bucket                 = aws_s3_bucket.this.id
  key                    = var.folder_name
  server_side_encryption = "aws:kms"
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  count  = var.control_object_ownership ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Deny all insecure transport
data "aws_iam_policy_document" "allow_ssl_requests_only" {
  statement {
    sid     = "AllowSSlRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [aws_s3_bucket.this.arn, "${aws_s3_bucket.this.arn}/*"]
  }
  statement {
    sid    = "S3BucketAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    actions = [
      "s3:*"
    ]
    resources = [aws_s3_bucket.this.arn, "${aws_s3_bucket.this.arn}/*"]
  }
  depends_on = [aws_s3_bucket.this]
}

# Uncomment it when S3 bucket policy is fixed.
data "aws_iam_policy_document" "combined" {
  source_policy_documents = compact([
    var.attach_policy ? var.policy_statements : "",
    data.aws_iam_policy_document.allow_ssl_requests_only.json,
  ])
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.combined.json
}


resource "aws_s3_bucket_acl" "this" {
  bucket     = aws_s3_bucket.this.id
  count      = local.create_bucket_acl ? 1 : 0
  acl        = var.acl == "null" ? null : var.acl
  depends_on = [aws_s3_bucket_ownership_controls.ownership]
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.s3_versioning
  }
}

resource "aws_s3_bucket_logging" "logging" {
  bucket        = aws_s3_bucket.this.bucket
  target_bucket = aws_s3_bucket.this.bucket
  target_prefix = "log/"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = module.aws_kms.id
      sse_algorithm     = "aws:kms"
    }
  }
}


module "aws_kms" {
  source = "../aws-kms"
  #source = "git::https://github.com/e2eSolutionArchitect/terraform-aws-kms.git?ref=v1.0.0"
  kms_name                = "s3 bucket encryption key for ${var.s3_bucket_name}"
  kms_alias               = var.s3_bucket_name
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  is_enabled              = var.is_enabled
  tags                    = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  # Enable bucket versioning first

  depends_on = [aws_s3_bucket_versioning.this]

  bucket = aws_s3_bucket.this.bucket
  count  = (var.enable_lifecycle_rule == true ? 1 : 0)
  rule {
    id = "config"

    filter {
      prefix = "upload/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}


resource "aws_s3_bucket_notification" "this" {
  count       = var.lambda_notifications != {} ? 1 : 0
  bucket      = aws_s3_bucket.this.id
  eventbridge = var.is_enabled_eventbridge
  dynamic "lambda_function" {
    for_each = var.lambda_notifications
    content {
      id                  = try(lambda_function.value.id, lambda_function.key)
      lambda_function_arn = lambda_function.value.function_arn
      events              = lambda_function.value.events
      filter_prefix       = try(lambda_function.value.filter_prefix, null)
      filter_suffix       = try(lambda_function.value.filter_suffix, null)
    }
  }
  depends_on = [aws_lambda_permission.allow, ]
}

resource "aws_lambda_permission" "allow" {
  for_each            = var.lambda_notifications != {} ? var.lambda_notifications : {}
  statement_id_prefix = "AllowLambdaS3BucketNotification-"
  action              = "lambda:InvokeFunction"
  function_name       = each.value.function_name
  qualifier           = try(each.value.qualifier, null)
  principal           = "s3.amazonaws.com"
  source_arn          = aws_s3_bucket.this.arn
  source_account      = var.source_account
}