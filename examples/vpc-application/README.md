# VPC domain with OpenSearch UI application

This isolated, low-cost test fixture proves that `modules/application` can create an SSO-enabled OpenSearch UI application and associate it programmatically with a VPC OpenSearch domain created in the same Terraform configuration.

> This is not a production architecture. The single-node domain has no high availability and incurs hourly charges until destroyed.

The test account must have an active IAM Identity Center instance in the selected Region. Administrator user/group IDs are variables and are never hard-coded. The application can be created with empty lists to test infrastructure integration, but interactive login requires at least one valid administrator ID.

The example configures a two-minute application delay after domain creation because the OpenSearch Application API can briefly report a newly completed domain as not ready.

```bash
export TF_VAR_master_user_password='Replace-With-A-Strong-Password-1!'
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

After verification, destroy the test resources:

```bash
terraform plan -destroy -out=destroy.tfplan
terraform apply destroy.tfplan
unset TF_VAR_master_user_password
```

The reusable files intended for team integration are in `modules/application`. This example is a reference and test harness only.