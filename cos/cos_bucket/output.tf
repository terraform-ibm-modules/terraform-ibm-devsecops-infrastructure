##############################################################################
# Outputs
##############################################################################

output "s3_endpoint_public" {
  value       = (var.enable_retention == false) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_public : ibm_cos_bucket.smart[0].s3_endpoint_public
  description = "The COS bucket public endpoint."
}

output "s3_endpoint_private" {
  value       = (var.enable_retention == false) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_private : ibm_cos_bucket.smart[0].s3_endpoint_private
  description = "The COS bucket private endpoint."
}

output "s3_endpoint_direct" {
  value       = (var.enable_retention == false) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_direct : ibm_cos_bucket.smart[0].s3_endpoint_direct
  description = "The COS bucket direct endpoint."
}

output "bucket_name" {
  value       = (var.add_cos_bucket_name_suffix) ? format("%s-%s", var.bucket_name, random_string.resource_suffix[0].result) : var.bucket_name
  description = "The name of bucket created by the SPS prefix and onboarding team name suffix"
}
