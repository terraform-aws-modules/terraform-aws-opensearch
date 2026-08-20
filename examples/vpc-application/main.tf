provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssoadmin_instances" "current" {}

locals {
  domain_name      = "${var.name_prefix}-domain"
  application_name = "${var.name_prefix}-app"

  tags = {
    Environment = "test"
    ManagedBy   = "Terraform"
    Purpose     = "opensearch-vpc-ui-poc"
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, { Name = var.name_prefix })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(local.tags, { Name = "${var.name_prefix}-private" })
}

module "opensearch_ui" {
  source = "../../modules/application"

  name   = local.application_name
  region = var.aws_region

  data_sources = {
    primary = {
      arn         = module.opensearch.domain_arn
      description = "VPC OpenSearch domain for the UI application POC"
    }
  }

  identity_center = {
    enabled      = true
    instance_arn = tolist(data.aws_ssoadmin_instances.current.arns)[0]
  }

  data_source_ready_delay   = "2m"
  dashboard_admin_user_ids  = var.dashboard_admin_user_ids
  dashboard_admin_group_ids = var.dashboard_admin_group_ids
  tags                      = local.tags
}

module "opensearch" {
  source = "../.."

  domain_name    = local.domain_name
  engine_version = var.engine_version
  region         = var.aws_region

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
      master_user_name     = "opensearch_admin"
      master_user_password = var.master_user_password
    }
  }

  domain_endpoint_options = {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  encrypt_at_rest         = { enabled = true }
  node_to_node_encryption = { enabled = true }

  vpc_options = {
    subnet_ids = [aws_subnet.private.id]
  }

  security_group_rules = {
    application_https = {
      type        = "ingress"
      description = "HTTPS from within the test VPC"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = var.vpc_cidr
    }
  }

  access_policy_statements = {
    application = {
      effect  = "Allow"
      actions = ["es:ESHttp*"]

      principals = [{
        type        = "AWS"
        identifiers = [module.opensearch_ui.identity_center_role_arn]
      }]
    }
  }

  auto_tune_options                     = {}
  create_cloudwatch_log_groups          = false
  create_cloudwatch_log_resource_policy = false
  log_publishing_options                = []
  off_peak_window_options               = {}
  software_update_options               = {}

  tags = local.tags
}