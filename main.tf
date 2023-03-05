locals {
  tags = merge(var.tags, { terraform-aws-modules = "opensearch" })
}

################################################################################
# Domain
################################################################################

resource "aws_opensearch_domain" "this" {
  count = var.create ? 1 : 0

  access_policies  = var.access_policies
  advanced_options = var.advanced_options

  dynamic "advanced_security_options" {
    for_each = length(var.advanced_security_options) > 0 ? [var.advanced_security_options] : []

    content {
      anonymous_auth_enabled         = try(advanced_security_options.value.anonymous_auth_enabled, null)
      enabled                        = try(advanced_security_options.value.enabled, true)
      internal_user_database_enabled = try(advanced_security_options.value.internal_user_database_enabled, null)

      dynamic "master_user_options" {
        for_each = try([advanced_security_options.value.master_user_options], [])

        content {
          master_user_arn      = try(master_user_options.value.master_user_arn, null)
          master_user_name     = try(master_user_options.value.master_user_name, null)
          master_user_password = try(master_user_options.value.master_user_password, null)
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

      dedicated_master_count   = try(cluster_config.value.dedicated_master_count, null)
      dedicated_master_enabled = try(cluster_config.value.dedicated_master_enabled, null)
      dedicated_master_type    = try(cluster_config.value.dedicated_master_type, null)
      instance_count           = try(cluster_config.value.instance_count, null)
      instance_type            = try(cluster_config.value.instance_type, null)
      warm_count               = try(cluster_config.value.warm_count, null)
      warm_enabled             = try(cluster_config.value.warm_enabled, null)
      warm_type                = try(cluster_config.value.warm_type, null)

      dynamic "zone_awareness_config" {
        for_each = try(cluster_config.value.zone_awareness_config, [])

        content {
          availability_zone_count = try(zone_awareness_config.value.availability_zone_count, null)
        }
      }

      zone_awareness_enabled = try(cluster_config.value.zone_awareness_enabled, null)
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
      enforce_https                   = try(domain_endpoint_options.value.enforce_https, null)
      tls_security_policy             = try(domain_endpoint_options.value.tls_security_policy, null)
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
      cloudwatch_log_group_arn = log_publishing_options.value.cloudwatch_log_group_arn
      enabled                  = try(log_publishing_options.value.enabled, null)
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
      security_group_ids = try(vpc_options.value.security_group_ids, null)
      subnet_ids         = try(vpc_options.value.subnet_ids, null)
    }
  }

  tags = local.tags
}
