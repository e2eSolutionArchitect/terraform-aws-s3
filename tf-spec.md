## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_kms"></a> [aws\_kms](#module\_aws\_kms) | ../aws-kms | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_permission.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_notification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_ownership_controls.ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.folder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow_ssl_requests_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | s3 bucket ACL type | `string` | `"private"` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | s3 attach\_policy | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS infrastructure regio | `string` | `null` | no |
| <a name="input_control_object_ownership"></a> [control\_object\_ownership](#input\_control\_object\_ownership) | s3 control\_object\_ownership | `string` | `"Enabled"` | no |
| <a name="input_create_folder"></a> [create\_folder](#input\_create\_folder) | s3 create\_folder | `bool` | `false` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | deletion\_window\_in\_days | `number` | `10` | no |
| <a name="input_enable_force_destroy"></a> [enable\_force\_destroy](#input\_enable\_force\_destroy) | enable\_force\_destroy | `bool` | `false` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | kms key enable\_key\_rotation | `bool` | `true` | no |
| <a name="input_enable_lifecycle_rule"></a> [enable\_lifecycle\_rule](#input\_enable\_lifecycle\_rule) | s3 life cycle | `bool` | `false` | no |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | s3 folder\_name | `string` | `null` | no |
| <a name="input_iam_policy_identifier"></a> [iam\_policy\_identifier](#input\_iam\_policy\_identifier) | iam policy identifier | `list(string)` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | kms key is\_enabled | `bool` | `true` | no |
| <a name="input_is_enabled_eventbridge"></a> [is\_enabled\_eventbridge](#input\_is\_enabled\_eventbridge) | If eventbridge is enabled for S3 trigger | `bool` | `false` | no |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | kms\_alias | `string` | `null` | no |
| <a name="input_lambda_notifications"></a> [lambda\_notifications](#input\_lambda\_notifications) | s3 lambda\_notifications | `any` | n/a | yes |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | s3 policy\_statements | `string` | `""` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | s3 bucket names | `string` | `null` | no |
| <a name="input_s3_versioning"></a> [s3\_versioning](#input\_s3\_versioning) | s3 versioning | `string` | `"Enabled"` | no |
| <a name="input_source_account"></a> [source\_account](#input\_source\_account) | source\_account AWS account no | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag map for the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | s3 aws\_s3\_bucket\_arn |
| <a name="output_aws_s3_bucket_server_side_encryption_configuratio_id"></a> [aws\_s3\_bucket\_server\_side\_encryption\_configuratio\_id](#output\_aws\_s3\_bucket\_server\_side\_encryption\_configuratio\_id) | s3 aws\_s3\_bucket\_server\_side\_encryption\_configuration id |
| <a name="output_aws_s3_bucket_versioning_id"></a> [aws\_s3\_bucket\_versioning\_id](#output\_aws\_s3\_bucket\_versioning\_id) | s3 aws\_s3\_bucket\_versioning id |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | s3 bucket\_regional\_domain\_name |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | s3 hosted\_zone\_id |
| <a name="output_id"></a> [id](#output\_id) | s3 aws\_s3\_bucket\_id |
| <a name="output_name"></a> [name](#output\_name) | s3 bucket name |
