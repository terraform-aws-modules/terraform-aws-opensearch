module "wrapper" {
  source = "../../modules/serverless"

  for_each = var.items

  access_policy                 = try(each.value.access_policy, var.defaults.access_policy, {})
  access_policy_description     = try(each.value.access_policy_description, var.defaults.access_policy_description, null)
  access_policy_name            = try(each.value.access_policy_name, var.defaults.access_policy_name, null)
  create                        = try(each.value.create, var.defaults.create, true)
  create_access_policy          = try(each.value.create_access_policy, var.defaults.create_access_policy, true)
  create_encryption_policy      = try(each.value.create_encryption_policy, var.defaults.create_encryption_policy, true)
  create_network_policy         = try(each.value.create_network_policy, var.defaults.create_network_policy, true)
  description                   = try(each.value.description, var.defaults.description, null)
  encryption_policy             = try(each.value.encryption_policy, var.defaults.encryption_policy, {})
  encryption_policy_description = try(each.value.encryption_policy_description, var.defaults.encryption_policy_description, null)
  encryption_policy_name        = try(each.value.encryption_policy_name, var.defaults.encryption_policy_name, null)
  name                          = try(each.value.name, var.defaults.name, "")
  network_policy                = try(each.value.network_policy, var.defaults.network_policy, {})
  network_policy_description    = try(each.value.network_policy_description, var.defaults.network_policy_description, null)
  network_policy_name           = try(each.value.network_policy_name, var.defaults.network_policy_name, null)
  tags                          = try(each.value.tags, var.defaults.tags, {})
  timeouts                      = try(each.value.timeouts, var.defaults.timeouts, {})
  type                          = try(each.value.type, var.defaults.type, null)
}
