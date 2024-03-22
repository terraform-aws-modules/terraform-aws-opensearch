# AWS OpenSearch Serverless Collection Example

Configuration in this directory creates an AWS OpenSearch serverless collection

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_opensearch_collection_disabled"></a> [opensearch\_collection\_disabled](#module\_opensearch\_collection\_disabled) | ../../modules/collection | n/a |
| <a name="module_opensearch_collection_private"></a> [opensearch\_collection\_private](#module\_opensearch\_collection\_private) | ../../modules/collection | n/a |
| <a name="module_opensearch_collection_public"></a> [opensearch\_collection\_public](#module\_opensearch\_collection\_public) | ../../modules/collection | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_opensearchserverless_vpc_endpoint.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_vpc_endpoint) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_opensearch_collection_private_access_policy"></a> [opensearch\_collection\_private\_access\_policy](#output\_opensearch\_collection\_private\_access\_policy) | The JSON policy document of the access policy |
| <a name="output_opensearch_collection_private_access_policy_version"></a> [opensearch\_collection\_private\_access\_policy\_version](#output\_opensearch\_collection\_private\_access\_policy\_version) | The version of the access policy |
| <a name="output_opensearch_collection_private_arn"></a> [opensearch\_collection\_private\_arn](#output\_opensearch\_collection\_private\_arn) | Amazon Resource Name (ARN) of the collection |
| <a name="output_opensearch_collection_private_dashboard_endpoint"></a> [opensearch\_collection\_private\_dashboard\_endpoint](#output\_opensearch\_collection\_private\_dashboard\_endpoint) | Collection-specific endpoint used to access OpenSearch Dashboards |
| <a name="output_opensearch_collection_private_encryption_policy"></a> [opensearch\_collection\_private\_encryption\_policy](#output\_opensearch\_collection\_private\_encryption\_policy) | The JSON policy document of the encryption policy |
| <a name="output_opensearch_collection_private_encryption_policy_version"></a> [opensearch\_collection\_private\_encryption\_policy\_version](#output\_opensearch\_collection\_private\_encryption\_policy\_version) | The version of the encryption policy |
| <a name="output_opensearch_collection_private_endpoint"></a> [opensearch\_collection\_private\_endpoint](#output\_opensearch\_collection\_private\_endpoint) | Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection |
| <a name="output_opensearch_collection_private_id"></a> [opensearch\_collection\_private\_id](#output\_opensearch\_collection\_private\_id) | Unique identifier for the collection |
| <a name="output_opensearch_collection_private_kms_key_arn"></a> [opensearch\_collection\_private\_kms\_key\_arn](#output\_opensearch\_collection\_private\_kms\_key\_arn) | The ARN of the Amazon Web Services KMS key used to encrypt the collection |
| <a name="output_opensearch_collection_private_lifecycle_policy"></a> [opensearch\_collection\_private\_lifecycle\_policy](#output\_opensearch\_collection\_private\_lifecycle\_policy) | The JSON policy document of the lifecycle policy |
| <a name="output_opensearch_collection_private_lifecycle_policy_version"></a> [opensearch\_collection\_private\_lifecycle\_policy\_version](#output\_opensearch\_collection\_private\_lifecycle\_policy\_version) | The version of the lifecycle policy |
| <a name="output_opensearch_collection_private_network_policy"></a> [opensearch\_collection\_private\_network\_policy](#output\_opensearch\_collection\_private\_network\_policy) | The JSON policy document of the network policy |
| <a name="output_opensearch_collection_private_network_policy_version"></a> [opensearch\_collection\_private\_network\_policy\_version](#output\_opensearch\_collection\_private\_network\_policy\_version) | The version of the network policy |
| <a name="output_opensearch_collection_public_access_policy"></a> [opensearch\_collection\_public\_access\_policy](#output\_opensearch\_collection\_public\_access\_policy) | The JSON policy document of the access policy |
| <a name="output_opensearch_collection_public_access_policy_version"></a> [opensearch\_collection\_public\_access\_policy\_version](#output\_opensearch\_collection\_public\_access\_policy\_version) | The version of the access policy |
| <a name="output_opensearch_collection_public_arn"></a> [opensearch\_collection\_public\_arn](#output\_opensearch\_collection\_public\_arn) | Amazon Resource Name (ARN) of the collection |
| <a name="output_opensearch_collection_public_dashboard_endpoint"></a> [opensearch\_collection\_public\_dashboard\_endpoint](#output\_opensearch\_collection\_public\_dashboard\_endpoint) | Collection-specific endpoint used to access OpenSearch Dashboards |
| <a name="output_opensearch_collection_public_encryption_policy"></a> [opensearch\_collection\_public\_encryption\_policy](#output\_opensearch\_collection\_public\_encryption\_policy) | The JSON policy document of the encryption policy |
| <a name="output_opensearch_collection_public_encryption_policy_version"></a> [opensearch\_collection\_public\_encryption\_policy\_version](#output\_opensearch\_collection\_public\_encryption\_policy\_version) | The version of the encryption policy |
| <a name="output_opensearch_collection_public_endpoint"></a> [opensearch\_collection\_public\_endpoint](#output\_opensearch\_collection\_public\_endpoint) | Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection |
| <a name="output_opensearch_collection_public_id"></a> [opensearch\_collection\_public\_id](#output\_opensearch\_collection\_public\_id) | Unique identifier for the collection |
| <a name="output_opensearch_collection_public_kms_key_arn"></a> [opensearch\_collection\_public\_kms\_key\_arn](#output\_opensearch\_collection\_public\_kms\_key\_arn) | The ARN of the Amazon Web Services KMS key used to encrypt the collection |
| <a name="output_opensearch_collection_public_lifecycle_policy"></a> [opensearch\_collection\_public\_lifecycle\_policy](#output\_opensearch\_collection\_public\_lifecycle\_policy) | The JSON policy document of the lifecycle policy |
| <a name="output_opensearch_collection_public_lifecycle_policy_version"></a> [opensearch\_collection\_public\_lifecycle\_policy\_version](#output\_opensearch\_collection\_public\_lifecycle\_policy\_version) | The version of the lifecycle policy |
| <a name="output_opensearch_collection_public_network_policy"></a> [opensearch\_collection\_public\_network\_policy](#output\_opensearch\_collection\_public\_network\_policy) | The JSON policy document of the network policy |
| <a name="output_opensearch_collection_public_network_policy_version"></a> [opensearch\_collection\_public\_network\_policy\_version](#output\_opensearch\_collection\_public\_network\_policy\_version) | The version of the network policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-opensearch/blob/master/LICENSE).
