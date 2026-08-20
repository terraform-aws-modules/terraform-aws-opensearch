# OpenSearch application module

Creates an Amazon OpenSearch UI application and associates it with one or more provisioned domains or serverless collections. It can optionally create the IAM role required for IAM Identity Center integration.

This module uses the native `aws_opensearch_application` resource in `hashicorp/aws` provider 6.51 or newer. It does not require the `awscc` provider.

## Usage with an existing domain module

```hcl
module "opensearch_ui" {
  source = "./modules/application"

  name = "${var.environment}-opensearch-ui"

  data_sources = {
    primary = {
      arn         = module.opensearch.domain_arn
      description = "${var.environment} VPC OpenSearch domain"
    }
  }

  identity_center = {
    enabled      = true
    instance_arn = var.identity_center_instance_arn
  }

  dashboard_admin_user_ids  = var.dashboard_admin_user_ids
  dashboard_admin_group_ids = var.dashboard_admin_group_ids
  data_source_ready_delay    = "2m"
  tags                       = local.tags
}
```

The domain ARN is a Terraform expression, not a hard-coded value. It also creates the dependency needed to wait for the domain before creating the application.

For an application created in the same apply as a new domain, set `data_source_ready_delay` to allow the OpenSearch Application API to recognize the new data source after domain creation. Existing domains can normally use the `0s` default.

If IAM is managed elsewhere, set `identity_center.create_role = false` and provide `identity_center.role_arn`.

## Authentication

The OpenSearch application can be created with empty administrator lists, but users cannot sign in until users or groups from the configured IAM Identity Center instance are assigned through `dashboard_admin_user_ids` or `dashboard_admin_group_ids`.

The associated domain resource policy must permit the Identity Center role to call the required `es:ESHttp*` operations. See `examples/vpc-application` for a complete reference.