##############################################################################
# Outputs
##############################################################################

output "s3_endpoint_public" {
  value       = (local.use_lite) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_public : ibm_cos_bucket.smart[0].s3_endpoint_public
  description = "The COS bucket public endpoint."
}

output "s3_endpoint_private" {
  value       = (local.use_lite) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_private : ibm_cos_bucket.smart[0].s3_endpoint_private
  description = "The COS bucket private endpoint."
}

output "s3_endpoint_direct" {
  value       = (local.use_lite) ? ibm_cos_bucket.smart_lite[0].s3_endpoint_direct : ibm_cos_bucket.smart[0].s3_endpoint_direct
  description = "The COS bucket direct endpoint."
}

output "bucket_name" {
  value       = var.bucket_name
  description = "The name of bucket created by the SPS prefix and onboarding team name suffix"
}