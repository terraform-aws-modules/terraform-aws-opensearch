# Small public OpenSearch domain

This example creates a low-cost, single-node Amazon OpenSearch Service domain and a managed OpenSearch UI application for personal testing. The domain uses one `t3.small.search` node and a 10 GiB gp3 EBS volume. The UI application declares the domain ARN as its data source.

> [!WARNING]
> This is not a production configuration. It has no high availability, and the public endpoint is appropriate only for short-lived testing. OpenSearch incurs hourly and storage charges until you run `terraform destroy`.

## Security model

- HTTPS is required.
- Encryption at rest and node-to-node encryption are enabled.
- Fine-grained access control uses OpenSearch's internal user database.
- The domain resource policy permits HTTP operations only from `allowed_cidr`.
- Set `allowed_cidr` to your current public IPv4 address with a `/32` suffix. Never use `0.0.0.0/0` for this example.

This POC intentionally creates a basic OpenSearch application without IAM Identity Center, application administrators, or a customer-managed KMS key. Associating a domain with an application does not automatically make the domain's internal master username and password the application's authentication mechanism.

The password is marked sensitive, but Terraform must still store it in state. Keep the state local and protected, or configure a secure encrypted remote backend before using this beyond a disposable test.

## Prerequisites

- Terraform 1.5.7 or newer
- AWS CLI credentials in the `Aaron` profile
- Permission to manage OpenSearch domains, domain policies, and OpenSearch applications
- Sufficient OpenSearch service quota in `us-east-1`

Confirm the AWS identity before creating anything:

```bash
aws sts get-caller-identity --profile Aaron
```

## Deploy

From this directory, export the two required variables. Choose a strong, unique password rather than the placeholder below:

```bash
export TF_VAR_allowed_cidr="$(curl -fsS https://checkip.amazonaws.com | tr -d '\n')/32"
export TF_VAR_master_user_password='Replace-With-A-Strong-Password-1!'
```

Initialize, review, and apply:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Domain creation commonly takes 15-30 minutes or longer. Do not commit `tfplan`, Terraform state, `.tfvars` files, or shell history containing secrets.

If your ISP changes your public IP, update `TF_VAR_allowed_cidr` and run `terraform apply` again.

## Connect

Show the URLs after the apply completes:

```bash
terraform output domain_endpoint
terraform output dashboard_url
terraform output application_endpoint
```

Test the API with HTTP basic authentication:

```bash
curl --user "opensearch_admin:${TF_VAR_master_user_password}" \
  "$(terraform output -raw domain_endpoint)"
```

The example exposes two different UI endpoints:

- `dashboard_url` is the OpenSearch Dashboards endpoint hosted by the domain. Open it in a browser and sign in with `opensearch_admin` and the password you exported.
- `application_endpoint` is the separately managed OpenSearch UI application associated with the domain. This first POC proves that Terraform can create and associate the resources; production user access should be configured separately, normally with IAM Identity Center.

On macOS, you can attempt to open the managed application endpoint with:

```bash
open "$(terraform output -raw application_endpoint)"
```

## Next step: VPC domain

The application resource can also associate with a VPC OpenSearch domain. If your team's existing Terraform exposes the domain ARN, the core association remains:

```hcl
resource "aws_opensearch_application" "this" {
  name = "example-opensearch-ui"

  data_source {
    data_source_arn         = module.opensearch.domain_arn
    data_source_description = "Team VPC OpenSearch domain"
  }
}
```

For that production-oriented phase, evaluate IAM Identity Center integration, domain authorization, and private network connectivity together. The ARN association alone does not grant users access to a private domain.

## Destroy

Destroy the domain as soon as testing is complete to stop ongoing charges:

```bash
terraform plan -destroy -out=destroy.tfplan
terraform apply destroy.tfplan
unset TF_VAR_master_user_password TF_VAR_allowed_cidr
```