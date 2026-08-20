locals {
  identity_center_role_arn = var.identity_center.enabled ? (
    var.identity_center.create_role ? aws_iam_role.identity_center[0].arn : var.identity_center.role_arn
  ) : null

  administrator_app_config = merge(
    length(var.dashboard_admin_user_ids) > 0 ? {
      "opensearchDashboards.dashboardAdmin.users" = join(",", var.dashboard_admin_user_ids)
    } : {},
    length(var.dashboard_admin_group_ids) > 0 ? {
      "opensearchDashboards.dashboardAdmin.groups" = join(",", var.dashboard_admin_group_ids)
    } : {},
    var.additional_app_config,
  )
}

resource "time_sleep" "data_source_ready" {
  count = var.create ? 1 : 0

  create_duration = var.data_source_ready_delay

  triggers = {
    data_sources = jsonencode(var.data_sources)
  }
}

resource "aws_opensearch_application" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  kms_key_arn = var.kms_key_arn
  region      = var.region

  dynamic "data_source" {
    for_each = var.data_sources

    content {
      data_source_arn         = data_source.value.arn
      data_source_description = data_source.value.description
    }
  }

  dynamic "app_config" {
    for_each = local.administrator_app_config

    content {
      key   = app_config.key
      value = app_config.value
    }
  }

  dynamic "iam_identity_center_options" {
    for_each = var.identity_center.enabled ? [var.identity_center] : []

    content {
      enabled                                      = true
      iam_identity_center_instance_arn             = iam_identity_center_options.value.instance_arn
      iam_role_for_identity_center_application_arn = local.identity_center_role_arn
    }
  }

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy.identity_center,
    time_sleep.data_source_ready,
  ]
}