data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  region     = data.aws_region.current.name

  static_domain_arn = "arn:${local.partition}:es:${local.region}:${local.account_id}:domain/${var.domain_name}"

  tags = merge(var.tags, { terraform-aws-modules = "opensearch" })
}

################################################################################
# Domain
################################################################################

resource "aws_opensearch_domain" "this" {
  count = var.create ? 1 : 0

  # Controlled via aws_opensearch_domain_policy below
  # access_policies  = var.access_policies
  advanced_options = var.advanced_options

  dynamic "advanced_security_options" {
    for_each = length(var.advanced_security_options) > 0 ? [var.advanced_security_options] : []

    content {
      anonymous_auth_enabled         = try(advanced_security_options.value.anonymous_auth_enabled, false)
      enabled                        = try(advanced_security_options.value.enabled, true)
      internal_user_database_enabled = try(advanced_security_options.value.internal_user_database_enabled, null)

      dynamic "master_user_options" {
        for_each = try([advanced_security_options.value.master_user_options], [{}])

        content {
          master_user_arn      = try(master_user_options.value.master_user_arn, null) == null ? try(master_user_options.value.master_user_arn, data.aws_iam_session_context.current.issuer_arn) : null
          master_user_name     = try(master_user_options.value.master_user_arn, null) == null ? try(master_user_options.value.master_user_name, null) : null
          master_user_password = try(master_user_options.value.master_user_arn, null) == null ? try(master_user_options.value.master_user_password, null) : null
        }
      }
    }
  }

  dynamic "auto_tune_options" {
    for_each = length(var.auto_tune_options) > 0 ? [var.auto_tune_options] : []

    content {
      desired_state = try(auto_tune_options.value.desired_state, "ENABLED")

      dynamic "maintenance_schedule" {
        for_each = try(auto_tune_options.value.maintenance_schedule, [])

        content {
          cron_expression_for_recurrence = maintenance_schedule.value.cron_expression_for_recurrence

          dynamic "duration" {
            for_each = maintenance_schedule.value.duration

            content {
              unit  = duration.value.unit
              value = duration.value.value
            }
          }

          start_at = maintenance_schedule.value.start_at
        }
      }

      rollback_on_disable = try(auto_tune_options.value.rollback_on_disable, null)
    }
  }

  dynamic "cluster_config" {
    for_each = length(var.cluster_config) > 0 ? [var.cluster_config] : []

    content {
      dynamic "cold_storage_options" {
        for_each = try(cluster_config.value.cold_storage_options, [])

        content {
          enabled = try(cold_storage_options.value.enabled, null)
        }
      }

      dedicated_master_count   = try(cluster_config.value.dedicated_master_count, 3)
      dedicated_master_enabled = try(cluster_config.value.dedicated_master_enabled, true)
      dedicated_master_type    = try(cluster_config.value.dedicated_master_type, null)
      instance_count           = try(cluster_config.value.instance_count, 3)
      instance_type            = try(cluster_config.value.instance_type, null)
      warm_count               = try(cluster_config.value.warm_count, null)
      warm_enabled             = try(cluster_config.value.warm_enabled, null)
      warm_type                = try(cluster_config.value.warm_type, null)

      dynamic "zone_awareness_config" {
        for_each = try([cluster_config.value.zone_awareness_config], [])

        content {
          availability_zone_count = try(zone_awareness_config.value.availability_zone_count, null)
        }
      }

      zone_awareness_enabled = try(cluster_config.value.zone_awareness_enabled, true)
    }
  }

  dynamic "cognito_options" {
    for_each = length(var.cognito_options) > 0 ? [var.cognito_options] : []

    content {
      enabled          = try(cognito_options.value.enabled, null)
      identity_pool_id = cognito_options.value.identity_pool_id
      role_arn         = cognito_options.value.role_arn
      user_pool_id     = cognito_options.value.user_pool_id
    }
  }

  dynamic "domain_endpoint_options" {
    for_each = length(var.domain_endpoint_options) > 0 ? [var.domain_endpoint_options] : []

    content {
      custom_endpoint                 = try(domain_endpoint_options.value.custom_endpoint, null)
      custom_endpoint_certificate_arn = try(domain_endpoint_options.value.custom_endpoint_certificate_arn, null)
      custom_endpoint_enabled         = try(domain_endpoint_options.value.custom_endpoint_enabled, null)
      enforce_https                   = try(domain_endpoint_options.value.enforce_https, true)
      tls_security_policy             = try(domain_endpoint_options.value.tls_security_policy, "Policy-Min-TLS-1-2-2019-07")
    }
  }

  domain_name = var.domain_name

  dynamic "ebs_options" {
    for_each = length(var.ebs_options) > 0 ? [var.ebs_options] : []

    content {
      ebs_enabled = try(ebs_options.value.ebs_enabled, true)
      iops        = try(ebs_options.value.iops, null)
      throughput  = try(ebs_options.value.throughput, null)
      volume_size = try(ebs_options.value.volume_size, null)
      volume_type = try(ebs_options.value.volume_type, "gp3")
    }
  }

  dynamic "encrypt_at_rest" {
    for_each = length(var.encrypt_at_rest) > 0 ? [var.encrypt_at_rest] : []

    content {
      enabled    = try(encrypt_at_rest.value.enabled, true)
      kms_key_id = try(encrypt_at_rest.value.kms_key_id, null)
    }
  }

  engine_version = var.engine_version

  dynamic "log_publishing_options" {
    for_each = { for opt in var.log_publishing_options : opt.log_type => opt }

    content {
      cloudwatch_log_group_arn = try(log_publishing_options.value.cloudwatch_log_group_arn, aws_cloudwatch_log_group.this[log_publishing_options.key].arn)
      enabled                  = try(log_publishing_options.value.enabled, true)
      log_type                 = log_publishing_options.value.log_type
    }
  }

  dynamic "node_to_node_encryption" {
    for_each = length(var.node_to_node_encryption) > 0 ? [var.node_to_node_encryption] : []

    content {
      enabled = try(node_to_node_encryption.value.enabled, true)
    }
  }

  dynamic "vpc_options" {
    for_each = length(var.vpc_options) > 0 ? [var.vpc_options] : []

    content {
      security_group_ids = concat(try(vpc_options.value.security_group_ids, []), aws_security_group.this[0].id)
      subnet_ids         = try(vpc_options.value.subnet_ids, null)
    }
  }

  tags = local.tags

  depends_on = [
    # https://github.com/hashicorp/terraform-provider-aws/issues/14497
    aws_opensearch_domain_policy.this,
  ]
}

################################################################################
# Cloudwatch Log Group
################################################################################

locals {
  create_cloudwatch_log_groups = var.create && var.create_cloudwatch_log_groups
}

resource "aws_cloudwatch_log_group" "this" {
  for_each = { for opt in var.log_publishing_options : opt.log_type => opt if try(opt.enabled, true) && local.create_cloudwatch_log_groups }

  name              = try(each.value.log_group_name, "/aws/opensearch/${var.domain_name}/${each.key}")
  retention_in_days = try(each.value.log_group_retention_in_days, var.cloudwatch_log_group_retention_in_days)
  kms_key_id        = try(each.value.log_group_kms_key_id, var.cloudwatch_log_group_kms_key_id)

  tags = merge(local.tags, try(each.value.log_group_tags, {}))
}

data "aws_iam_policy_document" "cloudwatch" {
  count = local.create_cloudwatch_log_groups && var.create_cloudwatch_log_resource_policy ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    # https://github.com/hashicorp/terraform-provider-aws/issues/14497
    # resources = coalescelist([for log in aws_cloudwatch_log_group.this : "${log.arn}:*"], ["arn:${local.partition}:logs:*"])
    resources = ["arn:${local.partition}:logs:*"]

    principals {
      identifiers = ["es.${data.aws_partition.current.dns_suffix}"]
      type        = "Service"
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [local.static_domain_arn]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  count = local.create_cloudwatch_log_groups && var.create_cloudwatch_log_resource_policy ? 1 : 0

  policy_document = data.aws_iam_policy_document.cloudwatch[0].json
  policy_name     = coalesce(var.cloudwatch_log_resource_policy_name, "opensearch-${var.domain_name}")
}

################################################################################
# Access Policy
################################################################################

locals {
  create_access_policy = var.create && var.create_access_policy && length(var.access_policy_statements) > 0
}

resource "aws_opensearch_domain_policy" "this" {
  count = var.create && var.enable_access_policy && (local.create_access_policy || var.access_policies != null) ? 1 : 0

  domain_name     = var.domain_name
  access_policies = local.create_access_policy ? data.aws_iam_policy_document.this[0].json : var.access_policies
}

data "aws_iam_policy_document" "this" {
  count = local.create_access_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.access_policy_statements

    content {
      sid         = try(statement.value.sid, null)
      actions     = try(statement.value.actions, null)
      not_actions = try(statement.value.not_actions, null)
      effect      = try(statement.value.effect, null)
      resources = try(statement.value.resources,
        [for path in try(statement.value.resource_paths, ["*"]) : "${local.static_domain_arn}/${path}"]
      )
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

################################################################################
# SAML Options
################################################################################

resource "aws_opensearch_domain_saml_options" "this" {
  count = var.create && var.create_saml_options ? 1 : 0

  domain_name = aws_opensearch_domain.this[0].domain_name

  dynamic "saml_options" {
    for_each = length(var.saml_options) > 0 ? [var.saml_options] : []

    content {
      enabled = try(saml_options.value.enabled, null)

      dynamic "idp" {
        for_each = try([saml_options.value.idp], [])

        content {
          entity_id        = idp.value.entity_id
          metadata_content = idp.value.metadata_content
        }
      }

      master_backend_role     = try(saml_options.value.master_backend_role, null)
      master_user_name        = try(saml_options.value.master_user_name, null)
      roles_key               = try(saml_options.value.roles_key, null)
      session_timeout_minutes = try(saml_options.value.session_timeout_minutes, null)
      subject_key             = try(saml_options.value.subject_key, null)
    }
  }
}

################################################################################
# Outbound Connections
################################################################################

resource "aws_opensearch_outbound_connection" "this" {
  for_each = { for k, v in var.outbound_connections : k => v if var.create }

  connection_alias = try(each.value.connection_alias, each.key)

  local_domain_info {
    owner_id    = try(each.value.local_domain_info.owner_id, local.account_id)
    region      = try(each.value.local_domain_info.region, local.region)
    domain_name = try(each.value.local_domain_info.domain_name, aws_opensearch_domain.this[0].domain_name)
  }

  remote_domain_info {
    owner_id    = each.value.remote_domain_info.owner_id
    region      = each.value.remote_domain_info.region
    domain_name = each.value.remote_domain_info.domain_name
  }
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group && length(var.vpc_options) > 0
  security_group_name   = try(coalesce(var.security_group_name, var.domain_name), "")
}

data "aws_subnet" "this" {
  count = local.create_security_group ? 1 : 0

  id = element(var.vpc_options.subnet_ids, 0)
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name                   = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix            = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  description            = var.security_group_description
  vpc_id                 = data.aws_subnet.this[0].vpc_id
  revoke_rules_on_delete = true

  tags = merge(
    local.tags,
    var.security_group_tags,
    {
      "Name" = local.security_group_name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id
  protocol          = try(each.value.protocol, "tcp")
  from_port         = try(each.value.from_port, 443)
  to_port           = try(each.value.to_port, 443)
  type              = try(each.value.type, "ingress")

  # Optional
  description              = lookup(each.value, "description", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  self                     = lookup(each.value, "self", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}
