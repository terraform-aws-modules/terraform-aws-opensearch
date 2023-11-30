# Complete AWS OpenSearch Example

Configuration in this directory creates:

- <XXX>

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.24 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.24 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_opensearch_complete"></a> [opensearch\_complete](#module\_opensearch\_complete) | ../.. | n/a |
| <a name="module_opensearch_default"></a> [opensearch\_default](#module\_opensearch\_default) | ../.. | n/a |
| <a name="module_opensearch_disabled"></a> [opensearch\_disabled](#module\_opensearch\_disabled) | ../.. | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_cloudwatch_logs"></a> [default\_cloudwatch\_logs](#output\_default\_cloudwatch\_logs) | Map of CloudWatch log groups created and their attributes |
| <a name="output_default_domain_arn"></a> [default\_domain\_arn](#output\_default\_domain\_arn) | The Amazon Resource Name (ARN) of the domain |
| <a name="output_default_domain_endpoint"></a> [default\_domain\_endpoint](#output\_default\_domain\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_default_domain_id"></a> [default\_domain\_id](#output\_default\_domain\_id) | The unique identifier for the domain |
| <a name="output_default_domain_kibana_endpoint"></a> [default\_domain\_kibana\_endpoint](#output\_default\_domain\_kibana\_endpoint) | Domain-specific endpoint for kibana without https scheme |
| <a name="output_default_outbound_connections"></a> [default\_outbound\_connections](#output\_default\_outbound\_connections) | Map of outbound connections created and their attributes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-opensearch/blob/master/LICENSE).
