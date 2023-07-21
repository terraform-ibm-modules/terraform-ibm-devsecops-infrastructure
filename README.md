<!-- BEGIN MODULE HOOK -->

<!-- Update the title to match the module name and add a description -->
## DevSecOps Infrastructure
<!-- UPDATE BADGE: Update the link for the following badge-->
![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-devsecops-infrastructure?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-infrastructure/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

A Terraform module for provisioning the infrastructure required by the DevSecOps CI, CD and CC toolchains. Both free and standard resources can be deployed.

<!-- Remove the content in this H2 heading after completing the steps -->
<!-- Remove the content in this previous H2 heading -->

## Reference architectures

## Usage

```hcl
module "terraform_devsecops_infra" {
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-infrastructure?ref=v1.0.0-beta.1"
  region                   = "us-south"
  resource_group           = "my-resource-group" #creates the resource group
  #or 
  #existing_resource_group = "Default"
  registry_namespace       = "my-registry-namespace-xyz1"
  vpc_name                 = "my-vpc-cluster-name"
  cluster_name             = "my-cluster"
  cos_bucket_name          = "my-cos-bucket-xyz1"
  cos_instance_name        = "my-cos-instance"
}

```

## Required IAM access policies

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->
<!-- END MODULE HOOK -->
<!-- BEGIN EXAMPLES HOOK -->
## Examples

<!-- END EXAMPLES HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >=1.52.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cd"></a> [cd](#module\_cd) | ./continuous_delivery | n/a |
| <a name="module_cos"></a> [cos](#module\_cos) | ./cos/cos_instance | n/a |
| <a name="module_cos_bucket"></a> [cos\_bucket](#module\_cos\_bucket) | ./cos/cos_bucket | n/a |
| <a name="module_icr"></a> [icr](#module\_icr) | ./icr | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | ./resource_group | n/a |
| <a name="module_sm"></a> [sm](#module\_sm) | ./secrets_manager/secrets_manager_instance | n/a |
| <a name="module_vpc_cluster"></a> [vpc\_cluster](#module\_vpc\_cluster) | ./cluster | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cd_instance_name"></a> [cd\_instance\_name](#input\_cd\_instance\_name) | The CD instance name. | `string` | `"my-cd-instance"` | no |
| <a name="input_cd_instance_region"></a> [cd\_instance\_region](#input\_cd\_instance\_region) | The CD instance region. | `string` | `"us-south"` | no |
| <a name="input_cd_resource_group_id"></a> [cd\_resource\_group\_id](#input\_cd\_resource\_group\_id) | The resource group ID containing the CD instance. | `string` | `""` | no |
| <a name="input_cd_service_plan"></a> [cd\_service\_plan](#input\_cd\_service\_plan) | The type of the plan `lite` or `professional`. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster where the application is deployed. This sets the same cluster for both CI and CD toolchains. See `ci_cluster_name` and `cd_cluster_name` to set different clusters. By default , the cluster namespace for CI will be set to `dev` and CD to `prod`. These can be changed using `ci_cluster_namespace` and `cd_cluster_namespace`. | `string` | `"iks-cluster-name"` | no |
| <a name="input_cos_bucket_name"></a> [cos\_bucket\_name](#input\_cos\_bucket\_name) | Set the name of your COS bucket. | `string` | `""` | no |
| <a name="input_cos_bucket_region"></a> [cos\_bucket\_region](#input\_cos\_bucket\_region) | The COS region. | `string` | `""` | no |
| <a name="input_cos_default_retention"></a> [cos\_default\_retention](#input\_cos\_default\_retention) | The default retention period are defined by this policy and apply to all objects in the bucket. | `string` | `"365"` | no |
| <a name="input_cos_instance_id"></a> [cos\_instance\_id](#input\_cos\_instance\_id) | The Id of the COS instance that contains the COS buckets. | `string` | `""` | no |
| <a name="input_cos_instance_name"></a> [cos\_instance\_name](#input\_cos\_instance\_name) | The name of the COS instance that contains the COS buckets. | `string` | `"my-cos-instance"` | no |
| <a name="input_cos_instance_region"></a> [cos\_instance\_region](#input\_cos\_instance\_region) | The location of the COS instance. | `string` | `"global"` | no |
| <a name="input_cos_maximum_retention"></a> [cos\_maximum\_retention](#input\_cos\_maximum\_retention) | Specifies maximum duration of time an object that can be kept unmodified in the bucket. | `string` | `"730"` | no |
| <a name="input_cos_minimum_retention"></a> [cos\_minimum\_retention](#input\_cos\_minimum\_retention) | Specifies minimum duration of time an object must be kept unmodified in the bucket. | `string` | `"365"` | no |
| <a name="input_cos_resource_group_id"></a> [cos\_resource\_group\_id](#input\_cos\_resource\_group\_id) | The resource group ID containing the COS instance. | `string` | `""` | no |
| <a name="input_cos_service_plan"></a> [cos\_service\_plan](#input\_cos\_service\_plan) | The plan type of the Cloud Object Storage instance. Can be `lite`, `standard`, `graduated-tier` | `string` | `""` | no |
| <a name="input_cos_storage_class"></a> [cos\_storage\_class](#input\_cos\_storage\_class) | The type of storage | `string` | `"smart"` | no |
| <a name="input_create_cd_instance"></a> [create\_cd\_instance](#input\_create\_cd\_instance) | Set to `true` to create the CD instance. | `bool` | `true` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Set to `true` to create cluster. | `bool` | `true` | no |
| <a name="input_create_cos"></a> [create\_cos](#input\_create\_cos) | Set to `true` to create COS. | `bool` | `true` | no |
| <a name="input_create_cos_bucket"></a> [create\_cos\_bucket](#input\_create\_cos\_bucket) | Set to `true` to create a COS bucket. | `bool` | `true` | no |
| <a name="input_create_icr"></a> [create\_icr](#input\_create\_icr) | Set to `true` to create ICR namespace | `bool` | `true` | no |
| <a name="input_create_sm"></a> [create\_sm](#input\_create\_sm) | Set to `true` to create Secrets Manager instance. | `bool` | `true` | no |
| <a name="input_existing_resource_group"></a> [existing\_resource\_group](#input\_existing\_resource\_group) | The name of an existing resource group to use. This supercedes the creation of a named resource group. See `resource_group` input. | `string` | `""` | no |
| <a name="input_flavor"></a> [flavor](#input\_flavor) | The cluster specs. | `string` | `"bx2.2x8"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | API key belonging to the account in which all the resources are created. | `string` | n/a | yes |
| <a name="input_icr_resource_group_id"></a> [icr\_resource\_group\_id](#input\_icr\_resource\_group\_id) | The resource group Id containing the registry region namespace. | `string` | `""` | no |
| <a name="input_is_permanant"></a> [is\_permanant](#input\_is\_permanant) | Specifies a permanent retention status either enable or disable for a bucket. | `bool` | `false` | no |
| <a name="input_kube_version"></a> [kube\_version](#input\_kube\_version) | The version of Kubernetes. | `string` | `"1.25.11"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region used for all resource creation unless a resource specific region is used. | `string` | `"us-south"` | no |
| <a name="input_registry_namespace"></a> [registry\_namespace](#input\_registry\_namespace) | A unique namespace within the IBM Cloud Container Registry region where the application image is stored. | `string` | `"my-registry-namespace"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The resource group that will be created and used, by default, for all resource creation and service instance lookups. | `string` | `""` | no |
| <a name="input_sm_location"></a> [sm\_location](#input\_sm\_location) | The region location of the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_sm_name"></a> [sm\_name](#input\_sm\_name) | The name of the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_sm_resource_group_id"></a> [sm\_resource\_group\_id](#input\_sm\_resource\_group\_id) | The ID of the resource group. | `string` | `""` | no |
| <a name="input_sm_service_endpoints"></a> [sm\_service\_endpoints](#input\_sm\_service\_endpoints) | The types of service endpoints supported by Secrets Manager. Can be `public`, `private` or `public-and-private`. | `string` | `"public-and-private"` | no |
| <a name="input_sm_service_plan"></a> [sm\_service\_plan](#input\_sm\_service\_plan) | The Secrets Manager service plan. `standard` or `trial`. | `string` | `""` | no |
| <a name="input_use_free_tier"></a> [use\_free\_tier](#input\_use\_free\_tier) | Set to `true` to use free tier. VPC cluster is not suported in a free tier. | `bool` | `false` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC. | `string` | `"vpc-name"` | no |
| <a name="input_vpc_region"></a> [vpc\_region](#input\_vpc\_region) | The VPC region. | `string` | `"us-south"` | no |
| <a name="input_vpc_resource_group_id"></a> [vpc\_resource\_group\_id](#input\_vpc\_resource\_group\_id) | The ID of the VPC resource group. | `string` | `""` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of worker nodes per zone in the default worker pool. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the VPC cluster. |
| <a name="output_cos_bucket_name"></a> [cos\_bucket\_name](#output\_cos\_bucket\_name) | The name of COS bucket. |
| <a name="output_cos_instance_id"></a> [cos\_instance\_id](#output\_cos\_instance\_id) | The instance Id of the COS instance. |
| <a name="output_cos_s3_endpoint_direct"></a> [cos\_s3\_endpoint\_direct](#output\_cos\_s3\_endpoint\_direct) | The COS bucket direct endpoint. |
| <a name="output_cos_s3_endpoint_private"></a> [cos\_s3\_endpoint\_private](#output\_cos\_s3\_endpoint\_private) | The COS bucket private endpoint. |
| <a name="output_cos_s3_endpoint_public"></a> [cos\_s3\_endpoint\_public](#output\_cos\_s3\_endpoint\_public) | The COS bucket public endpoint. |
| <a name="output_icr_namespace"></a> [icr\_namespace](#output\_icr\_namespace) | The ICR namespace. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The Id of the resource group. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group. |
| <a name="output_secrets_manager_instance_id"></a> [secrets\_manager\_instance\_id](#output\_secrets\_manager\_instance\_id) | The instance Id of the Secrets Manager instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
