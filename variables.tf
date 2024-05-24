########### Cluster ######################

variable "create_cluster" {
  type        = bool
  description = "Set to `true` to create cluster."
  default     = true
}

variable "worker_count" {
  type        = number
  description = "The number of worker nodes per zone in the default worker pool. "
  default     = 1
}

variable "flavor" {
  type        = string
  description = "The cluster specs."
  default     = "bx2.2x8"
}

variable "kube_version" {
  type        = string
  description = "The version of Kubernetes to use. Uses the latest version if not set."
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC."
  default     = "vpc-name"
}

variable "vpc_region" {
  type        = string
  description = "The VPC region."
  default     = "us-south"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed. This sets the same cluster for both CI and CD toolchains. See `ci_cluster_name` and `cd_cluster_name` to set different clusters. By default , the cluster namespace for CI will be set to `dev` and CD to `prod`. These can be changed using `ci_cluster_namespace` and `cd_cluster_namespace`."
  default     = "iks-cluster-name"
}

variable "cluster_resource_group_id" {
  type        = string
  description = "The ID of the cluster resource group."
  default     = ""
}

variable "wait_till" {
  type        = string
  description = "A status state check for the VPC cluster creation. Terraform will acknowledge a successful run based on the `wait_till` status value. To wait for full creation status including workers and ingress. Set the value to `IngressReady`. Other values include `Normal` and `MasterNodeReady`."
  default     = "OneWorkerNodeReady"
}

######### CONTINUOUS DELIVERY SERVICE #############
variable "create_cd_instance" {
  type        = bool
  description = "Set to `true` to create the CD instance."
  default     = true
}

variable "cd_instance_region" {
  type        = string
  description = "The CD instance region."
  default     = "us-south"
}

variable "cd_instance_name" {
  type        = string
  description = "The CD instance name."
  default     = "my-cd-instance"
}

variable "cd_service_plan" {
  type        = string
  description = " The type of the plan `lite` or `professional`."
  default     = ""
}

variable "cd_resource_group_id" {
  type        = string
  description = "The resource group ID containing the CD instance."
  default     = ""
}

#### COS MODULE VARIABLES ###############

variable "create_cos" {
  type        = bool
  description = "Set to `true` to create COS."
  default     = true
}

variable "create_cos_bucket" {
  type        = bool
  description = "Set to `true` to create a COS bucket."
  default     = true
}

variable "cos_add_random_cos_bucket_suffix" {
  type        = bool
  description = "Set to `true` to append a 4 character random string to the specified COS bucket name."
  default     = true
}

variable "cos_instance_name" {
  type        = string
  description = "The name of the COS instance that contains the COS buckets."
  default     = "my-cos-instance"
}

variable "cos_instance_id" {
  type        = string
  description = "The Id of the COS instance that contains the COS buckets."
  default     = ""
}

variable "cos_service_plan" {
  type        = string
  description = "The plan type of the Cloud Object Storage instance. Can be `lite`, `standard`, `graduated-tier`"
  default     = ""
}

variable "cos_instance_region" {
  type        = string
  description = "The location of the COS instance."
  default     = "global"
}

variable "cos_resource_group_id" {
  type        = string
  description = "The resource group ID containing the COS instance."
  default     = ""
}

variable "cos_storage_class" {
  type        = string
  description = "The type of storage"
  default     = "smart"
}

variable "cos_bucket_region" {
  type        = string
  description = "The COS region."
  default     = ""
}

variable "cos_bucket_name" {
  type        = string
  description = "Set the name of your COS bucket."
  default     = ""
}

variable "cos_default_retention" {
  type        = string
  description = "The default retention period are defined by this policy and apply to all objects in the bucket."
  default     = "365"
}

variable "cos_minimum_retention" {
  type        = string
  description = "Specifies minimum duration of time an object must be kept unmodified in the bucket."
  default     = "365"
}

variable "cos_maximum_retention" {
  type        = string
  description = "Specifies maximum duration of time an object that can be kept unmodified in the bucket."
  default     = "730"
}

variable "is_permanant" {
  type        = bool
  description = "Specifies a permanent retention status either enable or disable for a bucket."
  default     = false
}

#### ICR MODULE VARIABLES ###############

variable "create_icr" {
  type        = bool
  description = "Set to `true` to create ICR namespace"
  default     = true
}

variable "registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored."
  default     = "my-registry-namespace"
}

variable "icr_resource_group_id" {
  type        = string
  description = "The resource group Id containing the registry region namespace."
  default     = ""
}

####### Resource Group ###############
variable "existing_resource_group" {
  type        = string
  description = "The name of an existing resource group to use. This supercedes the creation of a named resource group. See `resource_group` input."
  default     = ""
}

variable "resource_group" {
  type        = string
  description = "The resource group that will be created and used, by default, for all resource creation and service instance lookups."
  default     = ""
}


############## SECRETS MANAGER ############################
############## SM Instance ########################

variable "create_or_link_to_secrets_manager" {
  type        = bool
  description = "Set to `true` to setup Secrets Manager. If `sm_instance_id` instance is set then that Secrets Manager will be used. Otherwise a new Secrets Manager instance will be provisioned."
  default     = true
}

variable "create_secrets" {
  type        = bool
  description = "Set to `true` to create `ibmcloud-api-key`, `cos-api-key` and `signing_key`."
  default     = true
}

variable "sm_name" {
  type        = string
  description = "The name of the Secrets Manager instance. "
  default     = ""
}

variable "sm_service_endpoints" {
  type        = string
  description = "The types of service endpoints supported by Secrets Manager. Can be `public`, `private` or `public-and-private`."
  default     = "public-and-private"
}

variable "sm_service_plan" {
  type        = string
  description = "The Secrets Manager service plan. `standard` or `trial`."
  default     = ""
}

variable "sm_location" {
  type        = string
  description = "The region location of the Secrets Manager instance. "
  default     = ""
}

variable "sm_existing_secret_group_id" {
  type        = string
  description = "The Secret Group ID of an exiting secret group in a Secrets Manager instance. This will take precendence over `sm_secret_group_name`."
  default     = ""
}

variable "sm_resource_group_id" {
  type        = string
  description = "The ID of the resource group."
  default     = ""
}

variable "sm_resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = ""
}

variable "sm_instance_id" {
  type        = string
  description = "The instance ID of the Secrets Manager."
  default     = ""
}

variable "sm_secret_group_name" {
  type        = string
  description = "The name of the Secrets Group that is created."
  default     = "devsecops"
}

########### SECRET MANAGER SECRETS ###########################

variable "cos_api_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = "Place Holder"
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "cos-api-key"
}

variable "iam_api_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = "Place Holder"
}

variable "iam_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "ibmcloud-api-key"
}

variable "signing_certificate_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = "Place Holder"
}

variable "signing_certifcate_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "signing-certificate"
}

variable "expiration_duration" {
  type        = string
  description = "Time in hrs representing the validity period of secrets in Secrets Manager. Default 90 days."
  default     = "2160h"
}

variable "signing_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = "Place Holder"
}

variable "signing_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "signing_key"
}

######KEY PROTECT ###########################

variable "create_key_protect" {
  type        = bool
  description = "Set to `true` to create Key Protect instance."
  default     = false
}

variable "kp_name" {
  type        = string
  description = "The name of the Key Protect instance. "
  default     = ""
}

variable "kp_location" {
  type        = string
  description = "The region location of the Key Protect instance. "
  default     = ""
}

variable "kp_resource_group_id" {
  type        = string
  description = "The ID of the resource group."
  default     = ""
}

################################

variable "region" {
  type        = string
  description = "The region used for all resource creation unless a resource specific region is used."
  default     = "us-south"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "API key belonging to the account in which all the resources are created."
  sensitive   = true
}

variable "use_free_tier" {
  type        = bool
  description = "Set to `true` to use free tier. VPC cluster is not suported in a free tier."
  default     = false
}
