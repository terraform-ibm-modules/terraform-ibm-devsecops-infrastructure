
locals {
  cos_tier = (
    (var.cos_service_plan != "") ? var.cos_service_plan :
    (var.use_free_tier) ? "lite" : "standard"
  )

  cos_retention = (var.use_free_tier) ? false : true

  sm_tier = (
    (var.sm_service_plan != "") ? var.sm_service_plan :
    (var.use_free_tier) ? "trial" : "standard"
  )

  cd_tier = (
    (var.cd_service_plan != "") ? var.cd_service_plan :
    (var.use_free_tier) ? "lite" : "professional"
  )

  use_vpc = (
    (var.use_free_tier) ? false : var.create_cluster
  )

  secret_duration = timeadd(time_static.timestamp.rfc3339, var.expiration_duration)
}

resource "time_static" "timestamp" {}

module "resource_group" {
  source                  = "./resource_group"
  existing_resource_group = var.existing_resource_group
  resource_group          = var.resource_group
}

module "icr" {
  count                = (var.create_icr) ? 1 : 0
  source               = "./icr"
  depends_on           = [module.resource_group]
  registry_namespace   = var.registry_namespace
  add_icr_name_suffix  = var.add_icr_name_suffix
  resource_group_id    = (var.icr_resource_group_id == "") ? module.resource_group.resource_group_id : var.icr_resource_group_id
  random_string_length = var.random_string_length
}

module "cos" {
  count             = (var.create_cos) ? 1 : 0
  source            = "./cos/cos_instance"
  depends_on        = [module.resource_group]
  instance_name     = var.cos_instance_name
  service_plan      = local.cos_tier
  instance_region   = (var.cos_instance_region == "") ? var.region : var.cos_instance_region
  resource_group_id = (var.cos_resource_group_id == "") ? module.resource_group.resource_group_id : var.cos_resource_group_id
}

module "cos_bucket" {
  count                      = (var.create_cos_bucket) ? 1 : 0
  source                     = "./cos/cos_bucket"
  depends_on                 = [module.cos]
  enable_retention           = local.cos_retention
  storage_class              = var.cos_storage_class
  bucket_region              = (var.cos_bucket_region == "") ? var.region : var.cos_bucket_region
  bucket_name                = var.cos_bucket_name
  cos_instance_id            = (var.cos_instance_id == "") ? module.cos[0].cos_instance_id : var.cos_instance_id
  default_retention          = var.cos_default_retention
  minimum_retention          = var.cos_minimum_retention
  maximum_retention          = var.cos_maximum_retention
  is_permanant               = var.is_permanant
  add_cos_bucket_name_suffix = var.cos_add_random_cos_bucket_suffix
  random_string_length       = var.random_string_length
}

#################### SECRETS #######################
resource "ibm_iam_api_key" "iam_api_key" {
  count = ((var.create_secrets == true) && ((var.create_or_link_to_secrets_manager == true) || (var.create_key_protect == true))) ? 1 : 0
  name  = "ibmcloud-api-key"
}

resource "ibm_iam_api_key" "cos_iam_api_key" {
  count = ((var.create_secrets == true) && ((var.create_or_link_to_secrets_manager == true) || (var.create_key_protect == true))) ? 1 : 0
  name  = "cos-api-key"
}

module "signing_keys" {
  count     = ((var.create_secrets == true) && ((var.create_or_link_to_secrets_manager == true) || (var.create_key_protect == true))) ? 1 : 0
  source    = "./gpg-key"
  gpg_name  = var.gpg_name
  gpg_email = var.gpg_email
}


####### SECRETS MANAGER #####################
module "sm" {
  count               = (var.create_or_link_to_secrets_manager) ? 1 : 0
  source              = "./secrets_manager/secrets_manager_instance"
  depends_on          = [module.resource_group]
  sm_name             = var.sm_name
  service_endpoints   = var.sm_service_endpoints
  service_plan        = local.sm_tier
  sm_location         = (var.sm_location == "") ? var.region : var.sm_location
  resource_group_id   = (var.sm_resource_group_id == "") ? module.resource_group.resource_group_id : var.sm_resource_group_id
  sm_instance_id      = var.sm_instance_id
  resource_group_name = var.sm_resource_group_name
}



module "sm_secret_group" {
  count                       = ((var.create_secrets == true) && (var.create_or_link_to_secrets_manager == true)) ? 1 : 0
  source                      = "./secrets_manager/secret_group"
  depends_on                  = [module.sm]
  sm_instance_id              = module.sm[0].instance_id
  sm_location                 = module.sm[0].sm_location
  sm_secret_group_name        = var.sm_secret_group_name
  sm_existing_secret_group_id = var.sm_existing_secret_group_id
}

module "sm_arbitrary_secret_ibmcloud_api_key" {
  count                   = ((var.create_secrets == true) && (var.create_or_link_to_secrets_manager == true)) ? 1 : 0
  depends_on              = [module.sm_secret_group]
  source                  = "./secrets_manager/arbitrary_secret"
  region                  = module.sm[0].sm_location
  secrets_manager_guid    = module.sm[0].instance_id
  secret_group_id         = module.sm_secret_group[0].secret_group_id
  secret_name             = var.iam_api_key_secret_name
  secret_description      = "The IBMCloud apikey for running the pipelines."
  secret_payload_password = (var.iam_api_key_secret == "") ? ibm_iam_api_key.iam_api_key[0].apikey : var.iam_api_key_secret
  expiration_date         = local.secret_duration
}

module "sm_arbitrary_secret_cos_api_key" {
  count                   = ((var.create_secrets == true) && (var.create_or_link_to_secrets_manager == true)) ? 1 : 0
  depends_on              = [module.sm_secret_group]
  source                  = "./secrets_manager/arbitrary_secret"
  region                  = module.sm[0].sm_location
  secrets_manager_guid    = module.sm[0].instance_id
  secret_group_id         = module.sm_secret_group[0].secret_group_id
  secret_name             = var.cos_api_key_secret_name
  secret_description      = "The COS apikey for accessing the associated COS instance."
  secret_payload_password = (var.cos_api_key_secret == "") ? ibm_iam_api_key.cos_iam_api_key[0].apikey : var.cos_api_key_secret
  expiration_date         = local.secret_duration
}

module "sm_arbitrary_secret_signing_key" {
  count                   = ((var.create_secrets == true) && (var.create_or_link_to_secrets_manager == true)) ? 1 : 0
  depends_on              = [module.sm_secret_group]
  source                  = "./secrets_manager/arbitrary_secret"
  region                  = module.sm[0].sm_location
  secrets_manager_guid    = module.sm[0].instance_id
  secret_group_id         = module.sm_secret_group[0].secret_group_id
  secret_name             = var.signing_key_secret_name
  secret_description      = "The gpg signing key for signing images."
  secret_payload_password = (var.signing_key_secret == "") ? module.signing_keys[0].gpg_key : var.signing_key_secret
  expiration_date         = local.secret_duration
}

module "sm_arbitrary_secret_signing_certifcate" {
  count                   = ((var.create_secrets == true) && (var.create_or_link_to_secrets_manager == true)) ? 1 : 0
  depends_on              = [module.sm_secret_group]
  source                  = "./secrets_manager/arbitrary_secret"
  region                  = module.sm[0].sm_location
  secrets_manager_guid    = module.sm[0].instance_id
  secret_group_id         = module.sm_secret_group[0].secret_group_id
  secret_name             = var.signing_certifcate_secret_name
  secret_description      = "The public component of the GPG signing key for validating image signatures."
  secret_payload_password = (var.signing_certificate_secret == "") ? module.signing_keys[0].gpg_public_certificate : var.signing_certificate_secret
  expiration_date         = local.secret_duration
}

############# KEY PROTECT #################################
module "kp" {
  count             = (var.create_key_protect) ? 1 : 0
  source            = "./keyprotect/keyprotect_instance"
  kp_name           = var.kp_name
  kp_location       = (var.kp_location == "") ? var.region : var.kp_location
  resource_group_id = (var.kp_resource_group_id == "") ? module.resource_group.resource_group_id : var.kp_resource_group_id
}

module "kp_secret_iamcloud_api_key" {
  count                   = ((var.create_secrets == true) && (var.create_key_protect == true)) ? 1 : 0
  source                  = "./keyprotect/keyprotect_key"
  depends_on              = [module.kp, ibm_iam_api_key.iam_api_key]
  keyprotect_guid         = module.kp[0].instance_id
  secret_name             = var.iam_api_key_secret_name
  is_standard_key         = true
  enable_force_delete     = true
  secret_payload_password = (var.iam_api_key_secret == "") ? ibm_iam_api_key.iam_api_key[0].apikey : var.iam_api_key_secret
}

module "kp_secret_cos_api_key" {
  count                   = ((var.create_secrets == true) && (var.create_key_protect == true)) ? 1 : 0
  source                  = "./keyprotect/keyprotect_key"
  depends_on              = [module.kp, ibm_iam_api_key.iam_api_key]
  keyprotect_guid         = module.kp[0].instance_id
  secret_name             = var.cos_api_key_secret_name
  is_standard_key         = true
  enable_force_delete     = true
  secret_payload_password = (var.cos_api_key_secret == "") ? ibm_iam_api_key.cos_iam_api_key[0].apikey : var.cos_api_key_secret
}

module "kp_secret_signing_key" {
  count                   = ((var.create_secrets == true) && (var.create_key_protect == true)) ? 1 : 0
  source                  = "./keyprotect/keyprotect_key"
  depends_on              = [module.kp, ibm_iam_api_key.iam_api_key]
  keyprotect_guid         = module.kp[0].instance_id
  secret_name             = var.signing_key_secret_name
  is_standard_key         = true
  enable_force_delete     = true
  secret_payload_password = (var.signing_key_secret == "") ? module.signing_keys[0].gpg_key : var.signing_key_secret
}

module "kp_secret_signing_certifcate" {
  count                   = ((var.create_secrets == true) && (var.create_key_protect == true)) ? 1 : 0
  source                  = "./keyprotect/keyprotect_key"
  depends_on              = [module.kp, ibm_iam_api_key.iam_api_key]
  keyprotect_guid         = module.kp[0].instance_id
  secret_name             = var.signing_certifcate_secret_name
  is_standard_key         = true
  enable_force_delete     = true
  secret_payload_password = (var.signing_certificate_secret == "") ? module.signing_keys[0].gpg_public_certificate : var.signing_certificate_secret
}

module "cd" {
  count             = (var.create_cd_instance) ? 1 : 0
  source            = "./continuous_delivery"
  instance_name     = var.cd_instance_name
  service_plan      = local.cd_tier
  instance_region   = (var.cd_instance_region == "") ? var.region : var.cd_instance_region
  resource_group_id = (var.cd_resource_group_id == "") ? module.resource_group.resource_group_id : var.cd_resource_group_id
}

module "vpc_cluster" {
  count             = (local.use_vpc) ? 1 : 0
  source            = "./cluster/vpc"
  depends_on        = [module.resource_group]
  vpc_name          = var.vpc_name
  cluster_name      = var.cluster_name
  worker_count      = var.worker_count
  flavor            = var.flavor
  wait_till         = var.wait_till
  kube_version      = var.kube_version
  vpc_region        = (var.vpc_region == "") ? var.region : var.vpc_region
  resource_group_id = (var.cluster_resource_group_id == "") ? module.resource_group.resource_group_id : var.cluster_resource_group_id
}

output "signing_key" {
  value = (var.signing_key_secret == "") ? module.signing_keys[0].gpg_key : var.signing_key_secret
}

output "signing_cert" {
 value = (var.signing_certificate_secret == "") ? module.signing_keys[0].gpg_public_certificate : var.signing_certificate_secret
}