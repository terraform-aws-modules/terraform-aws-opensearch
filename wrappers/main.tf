module "wrapper" {
  source = "../"

  for_each = var.items

  access_policies                         = try(each.value.access_policies, var.defaults.access_policies, null)
  access_policy_override_policy_documents = try(each.value.access_policy_override_policy_documents, var.defaults.access_policy_override_policy_documents, [])
  access_policy_source_policy_documents   = try(each.value.access_policy_source_policy_documents, var.defaults.access_policy_source_policy_documents, [])
  access_policy_statements                = try(each.value.access_policy_statements, var.defaults.access_policy_statements, {})
  advanced_options                        = try(each.value.advanced_options, var.defaults.advanced_options, {})
  advanced_security_options = try(each.value.advanced_security_options, var.defaults.advanced_security_options, {
    enabled                = true
    anonymous_auth_enabled = false
  })
  auto_tune_options = try(each.value.auto_tune_options, var.defaults.auto_tune_options, {
    desired_state       = "ENABLED"
    rollback_on_disable = "NO_ROLLBACK"
  })
  cloudwatch_log_group_kms_key_id        = try(each.value.cloudwatch_log_group_kms_key_id, var.defaults.cloudwatch_log_group_kms_key_id, null)
  cloudwatch_log_group_retention_in_days = try(each.value.cloudwatch_log_group_retention_in_days, var.defaults.cloudwatch_log_group_retention_in_days, 60)
  cloudwatch_log_resource_policy_name    = try(each.value.cloudwatch_log_resource_policy_name, var.defaults.cloudwatch_log_resource_policy_name, null)
  cluster_config = try(each.value.cluster_config, var.defaults.cluster_config, {
    dedicated_master_enabled = true
  })
  cognito_options                       = try(each.value.cognito_options, var.defaults.cognito_options, {})
  create                                = try(each.value.create, var.defaults.create, true)
  create_access_policy                  = try(each.value.create_access_policy, var.defaults.create_access_policy, true)
  create_cloudwatch_log_groups          = try(each.value.create_cloudwatch_log_groups, var.defaults.create_cloudwatch_log_groups, true)
  create_cloudwatch_log_resource_policy = try(each.value.create_cloudwatch_log_resource_policy, var.defaults.create_cloudwatch_log_resource_policy, true)
  create_saml_options                   = try(each.value.create_saml_options, var.defaults.create_saml_options, false)
  create_security_group                 = try(each.value.create_security_group, var.defaults.create_security_group, true)
  domain_endpoint_options = try(each.value.domain_endpoint_options, var.defaults.domain_endpoint_options, {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  })
  domain_name = try(each.value.domain_name, var.defaults.domain_name, "")
  ebs_options = try(each.value.ebs_options, var.defaults.ebs_options, {
    ebs_enabled = true
    volume_size = 64
    volume_type = "gp3"
  })
  enable_access_policy = try(each.value.enable_access_policy, var.defaults.enable_access_policy, true)
  encrypt_at_rest = try(each.value.encrypt_at_rest, var.defaults.encrypt_at_rest, {
    enabled = true
  })
  engine_version = try(each.value.engine_version, var.defaults.engine_version, null)
  log_publishing_options = try(each.value.log_publishing_options, var.defaults.log_publishing_options, [
    { log_type = "INDEX_SLOW_LOGS" },
    { log_type = "SEARCH_SLOW_LOGS" },
  ])
  node_to_node_encryption = try(each.value.node_to_node_encryption, var.defaults.node_to_node_encryption, {
    enabled = true
  })
  off_peak_window_options = try(each.value.off_peak_window_options, var.defaults.off_peak_window_options, {
    enabled = true
    off_peak_window = {
      hours = 7
    }
  })
  outbound_connections           = try(each.value.outbound_connections, var.defaults.outbound_connections, {})
  package_associations           = try(each.value.package_associations, var.defaults.package_associations, {})
  saml_options                   = try(each.value.saml_options, var.defaults.saml_options, {})
  security_group_description     = try(each.value.security_group_description, var.defaults.security_group_description, null)
  security_group_name            = try(each.value.security_group_name, var.defaults.security_group_name, null)
  security_group_rules           = try(each.value.security_group_rules, var.defaults.security_group_rules, {})
  security_group_tags            = try(each.value.security_group_tags, var.defaults.security_group_tags, {})
  security_group_use_name_prefix = try(each.value.security_group_use_name_prefix, var.defaults.security_group_use_name_prefix, true)
  software_update_options = try(each.value.software_update_options, var.defaults.software_update_options, {
    auto_software_update_enabled = true
  })
  tags          = try(each.value.tags, var.defaults.tags, {})
  vpc_endpoints = try(each.value.vpc_endpoints, var.defaults.vpc_endpoints, {})
  vpc_options   = try(each.value.vpc_options, var.defaults.vpc_options, {})
}
