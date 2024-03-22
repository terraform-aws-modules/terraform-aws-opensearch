# Complete AWS OpenSearch Example

Configuration in this directory creates an AWS OpenSearch domain and resources

## Usage

Ensure you have a service-linked role for OpenSearch before deploying the example. You can use the following command to create one:

```bash
aws iam create-service-linked-role --aws-service-name es.amazonaws.com
```

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
| <a name="module_opensearch"></a> [opensearch](#module\_opensearch) | ../.. | n/a |
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
| <a name="output_cloudwatch_logs"></a> [cloudwatch\_logs](#output\_cloudwatch\_logs) | Map of CloudWatch log groups created and their attributes |
| <a name="output_domain_arn"></a> [domain\_arn](#output\_domain\_arn) | The Amazon Resource Name (ARN) of the domain |
| <a name="output_domain_dashboard_endpoint"></a> [domain\_dashboard\_endpoint](#output\_domain\_dashboard\_endpoint) | Domain-specific endpoint for Dashboard without https scheme |
| <a name="output_domain_endpoint"></a> [domain\_endpoint](#output\_domain\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | The unique identifier for the domain |
| <a name="output_outbound_connections"></a> [outbound\_connections](#output\_outbound\_connections) | Map of outbound connections created and their attributes |
| <a name="output_package_associations"></a> [package\_associations](#output\_package\_associations) | Map of package associations created and their attributes |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_vpc_endpoints"></a> [vpc\_endpoints](#output\_vpc\_endpoints) | Map of VPC endpoints created and their attributes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-opensearch/blob/master/LICENSE).
