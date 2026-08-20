provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "opensearch" {
  source = "../.."

  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config = {
    dedicated_master_enabled = false
    instance_count           = 1
    instance_type            = "t3.small.search"
    zone_awareness_enabled   = false
  }

  ebs_options = {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp3"
  }

  advanced_security_options = {
    enabled                        = true
    anonymous_auth_enabled         = false
    internal_user_database_enabled = true

    master_user_options = {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  domain_endpoint_options = {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  encrypt_at_rest = {
    enabled = true
  }

  node_to_node_encryption = {
    enabled = true
  }

  access_policy_statements = {
    current_ip = {
      effect = "Allow"

      principals = [{
        type        = "*"
        identifiers = ["*"]
      }]

      actions = ["es:ESHttp*"]

      conditions = [{
        test     = "IpAddress"
        variable = "aws:SourceIp"
        values   = [var.allowed_cidr]
      }]
    }
  }

  # These resources are useful for larger deployments, but are unnecessary for
  # this public, single-node test domain.
  auto_tune_options                     = {}
  create_cloudwatch_log_groups          = false
  create_cloudwatch_log_resource_policy = false
  create_security_group                 = false
  log_publishing_options                = []
  off_peak_window_options               = {}
  software_update_options               = {}

  tags = {
    Environment = "test"
    ManagedBy   = "Terraform"
    Purpose     = "small-opensearch-example"
  }
}

################################################################################
# OpenSearch UI Application
################################################################################

resource "aws_opensearch_application" "this" {
  name   = var.application_name
  region = var.aws_region

  data_source {
    data_source_arn         = module.opensearch.domain_arn
    data_source_description = "OpenSearch domain for the UI application POC"
  }

  tags = {
    Environment = "test"
    ManagedBy   = "Terraform"
    Purpose     = "small-opensearch-ui-example"
  }
}