module "wrapper" {
  source = "../../modules/serverless"

  for_each = var.items

  create                                 = try(each.value.create, var.defaults.create, true)
  create_encryption_policy               = try(each.value.create_encryption_policy, var.defaults.create_encryption_policy, true)
  create_network_policy                  = try(each.value.create_network_policy, var.defaults.create_network_policy, true)
  description                            = try(each.value.description, var.defaults.description, null)
  encryption_security_policy             = try(each.value.encryption_security_policy, var.defaults.encryption_security_policy, {})
  encryption_security_policy_description = try(each.value.encryption_security_policy_description, var.defaults.encryption_security_policy_description, null)
  encryption_security_policy_name        = try(each.value.encryption_security_policy_name, var.defaults.encryption_security_policy_name, null)
  name                                   = try(each.value.name, var.defaults.name, "")
  network_security_policy                = try(each.value.network_security_policy, var.defaults.network_security_policy, {})
  network_security_policy_description    = try(each.value.network_security_policy_description, var.defaults.network_security_policy_description, null)
  network_security_policy_name           = try(each.value.network_security_policy_name, var.defaults.network_security_policy_name, null)
  tags                                   = try(each.value.tags, var.defaults.tags, {})
  timeouts                               = try(each.value.timeouts, var.defaults.timeouts, {})
  type                                   = try(each.value.type, var.defaults.type, null)
}
