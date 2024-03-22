# AWS OpenSearch Collection Terraform module

Terraform module which creates AWS OpenSearch collection resources.

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples) directory for working examples to reference:

```hcl
module "opensearch_serverless" {
  source = "terraform-aws-modules/opensearch/aws//modules/collection"

  name        = "example"
  description = "Example OpenSearch Serverless collection"
  type        = "SEARCH"

  create_access_policy  = true
  create_network_policy = true
  network_policy = {
    AllowFromPublic = false
    SourceVPCEs = [
      "vpce-050f79086ee71ac05"
    ]
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```
## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples/complete)
- [Serverless](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples/collection)

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_opensearchserverless_access_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_access_policy) | resource |
| [aws_opensearchserverless_collection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_collection) | resource |
| [aws_opensearchserverless_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_lifecycle_policy) | resource |
| [aws_opensearchserverless_security_policy.encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_security_policy) | resource |
| [aws_opensearchserverless_security_policy.network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_security_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | Access policy to apply to the collection | `any` | `{}` | no |
| <a name="input_access_policy_collection_permissions"></a> [access\_policy\_collection\_permissions](#input\_access\_policy\_collection\_permissions) | Access policy permissions for the collection | `list(string)` | <pre>[<br>  "aoss:*"<br>]</pre> | no |
| <a name="input_access_policy_description"></a> [access\_policy\_description](#input\_access\_policy\_description) | Description of the access policy | `string` | `null` | no |
| <a name="input_access_policy_index_permissions"></a> [access\_policy\_index\_permissions](#input\_access\_policy\_index\_permissions) | Access policy permissions for the collection index | `list(string)` | <pre>[<br>  "aoss:*"<br>]</pre> | no |
| <a name="input_access_policy_name"></a> [access\_policy\_name](#input\_access\_policy\_name) | Name of the access policy | `string` | `null` | no |
| <a name="input_access_policy_principals"></a> [access\_policy\_principals](#input\_access\_policy\_principals) | Access policy principals | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_access_policy"></a> [create\_access\_policy](#input\_create\_access\_policy) | Determines whether an access policy will be created | `bool` | `false` | no |
| <a name="input_create_encryption_policy"></a> [create\_encryption\_policy](#input\_create\_encryption\_policy) | Determines whether an encryption policy will be created | `bool` | `true` | no |
| <a name="input_create_lifecycle_policy"></a> [create\_lifecycle\_policy](#input\_create\_lifecycle\_policy) | Determines whether an lifecycle policy will be created | `bool` | `false` | no |
| <a name="input_create_network_policy"></a> [create\_network\_policy](#input\_create\_network\_policy) | Determines whether an network policy will be created | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the collection | `string` | `null` | no |
| <a name="input_encryption_policy"></a> [encryption\_policy](#input\_encryption\_policy) | Encryption policy to apply to the collection | `any` | `{}` | no |
| <a name="input_encryption_policy_description"></a> [encryption\_policy\_description](#input\_encryption\_policy\_description) | Description of the encryption policy | `string` | `null` | no |
| <a name="input_encryption_policy_name"></a> [encryption\_policy\_name](#input\_encryption\_policy\_name) | Name of the encryption policy | `string` | `null` | no |
| <a name="input_lifecycle_policy_description"></a> [lifecycle\_policy\_description](#input\_lifecycle\_policy\_description) | Description of the lifecycle policy | `string` | `null` | no |
| <a name="input_lifecycle_policy_min_index_retention"></a> [lifecycle\_policy\_min\_index\_retention](#input\_lifecycle\_policy\_min\_index\_retention) | The minimum period, in days (d) or hours (h), to retain the document in the index. The lower bound is `24h` and the upper bound is `3650d` | `string` | `null` | no |
| <a name="input_lifecycle_policy_name"></a> [lifecycle\_policy\_name](#input\_lifecycle\_policy\_name) | Name of the lifecycle policy | `string` | `null` | no |
| <a name="input_lifecycle_policy_no_min_index_retention"></a> [lifecycle\_policy\_no\_min\_index\_retention](#input\_lifecycle\_policy\_no\_min\_index\_retention) | If true, OpenSearch Serverless retains documents indefinitely | `bool` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the collection | `string` | `""` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Network policy to apply to the collection | `any` | `{}` | no |
| <a name="input_network_policy_description"></a> [network\_policy\_description](#input\_network\_policy\_description) | Description of the network policy | `string` | `null` | no |
| <a name="input_network_policy_name"></a> [network\_policy\_name](#input\_network\_policy\_name) | Name of the network policy | `string` | `null` | no |
| <a name="input_standby_replicas"></a> [standby\_replicas](#input\_standby\_replicas) | Indicates whether standby replicas should be used for a collection. One of ENABLED or DISABLED. Defaults to ENABLED. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create and delete timeout configurations for the collection | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of collection. One of `SEARCH`, `TIMESERIES`, or `VECTORSEARCH`. Defaults to `TIMESERIES` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_policy"></a> [access\_policy](#output\_access\_policy) | The JSON policy document of the access policy |
| <a name="output_access_policy_version"></a> [access\_policy\_version](#output\_access\_policy\_version) | The version of the access policy |
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the collection |
| <a name="output_dashboard_endpoint"></a> [dashboard\_endpoint](#output\_dashboard\_endpoint) | Collection-specific endpoint used to access OpenSearch Dashboards |
| <a name="output_encryption_policy"></a> [encryption\_policy](#output\_encryption\_policy) | The JSON policy document of the encryption policy |
| <a name="output_encryption_policy_version"></a> [encryption\_policy\_version](#output\_encryption\_policy\_version) | The version of the encryption policy |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection |
| <a name="output_id"></a> [id](#output\_id) | Unique identifier for the collection |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The ARN of the Amazon Web Services KMS key used to encrypt the collection |
| <a name="output_lifecycle_policy"></a> [lifecycle\_policy](#output\_lifecycle\_policy) | The JSON policy document of the lifecycle policy |
| <a name="output_lifecycle_policy_version"></a> [lifecycle\_policy\_version](#output\_lifecycle\_policy\_version) | The version of the lifecycle policy |
| <a name="output_network_policy"></a> [network\_policy](#output\_network\_policy) | The JSON policy document of the network policy |
| <a name="output_network_policy_version"></a> [network\_policy\_version](#output\_network\_policy\_version) | The version of the network policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-opensearch/blob/master/LICENSE).
