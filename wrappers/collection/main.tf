module "wrapper" {
  source = "../../modules/collection"

  for_each = var.items

  access_policy                           = try(each.value.access_policy, var.defaults.access_policy, {})
  access_policy_collection_permissions    = try(each.value.access_policy_collection_permissions, var.defaults.access_policy_collection_permissions, ["aoss:*"])
  access_policy_description               = try(each.value.access_policy_description, var.defaults.access_policy_description, null)
  access_policy_index_permissions         = try(each.value.access_policy_index_permissions, var.defaults.access_policy_index_permissions, ["aoss:*"])
  access_policy_name                      = try(each.value.access_policy_name, var.defaults.access_policy_name, null)
  access_policy_principals                = try(each.value.access_policy_principals, var.defaults.access_policy_principals, [])
  create                                  = try(each.value.create, var.defaults.create, true)
  create_access_policy                    = try(each.value.create_access_policy, var.defaults.create_access_policy, false)
  create_encryption_policy                = try(each.value.create_encryption_policy, var.defaults.create_encryption_policy, true)
  create_lifecycle_policy                 = try(each.value.create_lifecycle_policy, var.defaults.create_lifecycle_policy, false)
  create_network_policy                   = try(each.value.create_network_policy, var.defaults.create_network_policy, false)
  description                             = try(each.value.description, var.defaults.description, null)
  encryption_policy                       = try(each.value.encryption_policy, var.defaults.encryption_policy, {})
  encryption_policy_description           = try(each.value.encryption_policy_description, var.defaults.encryption_policy_description, null)
  encryption_policy_name                  = try(each.value.encryption_policy_name, var.defaults.encryption_policy_name, null)
  lifecycle_policy_description            = try(each.value.lifecycle_policy_description, var.defaults.lifecycle_policy_description, null)
  lifecycle_policy_min_index_retention    = try(each.value.lifecycle_policy_min_index_retention, var.defaults.lifecycle_policy_min_index_retention, null)
  lifecycle_policy_name                   = try(each.value.lifecycle_policy_name, var.defaults.lifecycle_policy_name, null)
  lifecycle_policy_no_min_index_retention = try(each.value.lifecycle_policy_no_min_index_retention, var.defaults.lifecycle_policy_no_min_index_retention, null)
  name                                    = try(each.value.name, var.defaults.name, "")
  network_policy                          = try(each.value.network_policy, var.defaults.network_policy, {})
  network_policy_description              = try(each.value.network_policy_description, var.defaults.network_policy_description, null)
  network_policy_name                     = try(each.value.network_policy_name, var.defaults.network_policy_name, null)
  standby_replicas                        = try(each.value.standby_replicas, var.defaults.standby_replicas, null)
  tags                                    = try(each.value.tags, var.defaults.tags, {})
  timeouts                                = try(each.value.timeouts, var.defaults.timeouts, {})
  type                                    = try(each.value.type, var.defaults.type, null)
}
