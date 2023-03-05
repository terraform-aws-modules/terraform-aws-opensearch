# AWS OpenSearch Terraform module

Terraform module which creates AWS OpenSearch resources.

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples) directory for working examples to reference:

```hcl
module "opensearch" {
  source = "terraform-aws-modules/opensearch/aws"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-opensearch/tree/master/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.29 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.29 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_opensearch_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | IAM policy document specifying the access policies for the domain | `string` | `null` | no |
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply | `map(string)` | `{}` | no |
| <a name="input_advanced_security_options"></a> [advanced\_security\_options](#input\_advanced\_security\_options) | Configuration block for [fine-grained access control](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/fgac.html) | `any` | `{}` | no |
| <a name="input_auto_tune_options"></a> [auto\_tune\_options](#input\_auto\_tune\_options) | Configuration block for the Auto-Tune options of the domain | `any` | `{}` | no |
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | Configuration block for the cluster of the domain | `any` | `{}` | no |
| <a name="input_cognito_options"></a> [cognito\_options](#input\_cognito\_options) | Configuration block for authenticating Kibana with Cognito | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_domain_endpoint_options"></a> [domain\_endpoint\_options](#input\_domain\_endpoint\_options) | Configuration block for domain endpoint HTTP(S) related options | `any` | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the domain | `string` | `""` | no |
| <a name="input_ebs_options"></a> [ebs\_options](#input\_ebs\_options) | Configuration block for EBS related options, may be required based on chosen [instance size](https://aws.amazon.com/elasticsearch-service/pricing/) | `any` | `{}` | no |
| <a name="input_encrypt_at_rest"></a> [encrypt\_at\_rest](#input\_encrypt\_at\_rest) | Configuration block for encrypting at rest | `any` | `{}` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of the OpenSearch engine to use | `string` | `"OpenSearch_2.3"` | no |
| <a name="input_log_publishing_options"></a> [log\_publishing\_options](#input\_log\_publishing\_options) | Configuration block for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log\_type, within the same resource | `any` | `[]` | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Configuration block for node-to-node encryption options | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_options"></a> [vpc\_options](#input\_vpc\_options) | Configuration block for VPC related options. Adding or removing this configuration forces a new resource ([documentation](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-vpc-limitations)) | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_arn"></a> [domain\_arn](#output\_domain\_arn) | The Amazon Resource Name (ARN) of the domain |
| <a name="output_domain_endpoint"></a> [domain\_endpoint](#output\_domain\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | The unique identifier for the domain |
| <a name="output_domain_kibana_endpoint"></a> [domain\_kibana\_endpoint](#output\_domain\_kibana\_endpoint) | Domain-specific endpoint for kibana without https scheme |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-opensearch/blob/master/LICENSE).
