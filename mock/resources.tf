resource "random_string" "random_string" {
  length  = 4
  special = false
  lower   = true
  upper   = false
}

module "main" {
  source                      = "./.."
  for_each                    = local.resources
  acl              = each.value.acl
  enable_force_destroy              = each.value.enable_force_destroy
  folder_names              = each.value.folder_names
  control_object_ownership              = each.value.control_object_ownership
  s3_versioning              = each.value.s3_versioning
  enable_lifecycle_rule              = each.value.enable_lifecycle_rule
  source_account              = each.value.source_account
  deletion_window_in_days              = each.value.kms.deletion_window_in_days
  enable_key_rotation              = each.value.kms.enable_key_rotation
  is_enabled              = each.value.kms.is_enabled
  attach_policy              = each.value.iam.attach_policy
  policy_statements              = each.value.iam.policy_statements
  lambda_notifications              = each.value.notification.lambda_notifications
  is_enabled_eventbridge              = each.value.notification.is_enabled_eventbridge
  tags                      = local.tags
}