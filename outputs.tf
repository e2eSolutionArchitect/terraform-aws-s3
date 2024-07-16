

output "arn" {
  value       = try(values(aws_s3_bucket.this)[*].arn, "")
  description = "s3 aws_s3_bucket_arn"
}
output "id" {
  value       = try(values(aws_s3_bucket.this)[*].id, "")
  description = "s3 aws_s3_bucket_id"
}

output "name" {
  value       = try(values(aws_s3_bucket.this)[*].s3_bucket_name, "")
  description = "s3 bucket name"
}

output "hosted_zone_id" {
  value       = try(values(aws_s3_bucket.this)[*].hosted_zone_id, "")
  description = "s3 hosted_zone_id"
}


output "bucket_regional_domain_name" {
  value       = try(values(aws_s3_bucket.this)[*].bucket_regional_domain_name, "")
  description = "s3 bucket_regional_domain_name"
}


output "aws_s3_bucket_versioning_id" {
  value       = try(values(aws_s3_bucket_versioning.this)[*].id, "")
  description = "s3 aws_s3_bucket_versioning id"
}

output "aws_s3_bucket_server_side_encryption_configuratio_id" {
  value       = try(values(aws_s3_bucket_server_side_encryption_configuration.this)[*].id, "")
  description = "s3 aws_s3_bucket_server_side_encryption_configuration id"
}



