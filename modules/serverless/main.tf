locals {
  tags = merge(var.tags, { terraform-aws-modules = "opensearch" })
}

################################################################################
# Collection
################################################################################

resource "aws_opensearchserverless_collection" "this" {
  count = var.create ? 1 : 0

  description = var.description
  name        = var.name
  type        = var.type

  tags = local.tags

  timeouts {
    create = try(var.timeouts.delete, null)
    delete = try(var.timeouts.delete, null)
  }

  depends_on = [
    aws_opensearchserverless_security_policy.encryption
  ]
}

################################################################################
# Security Policy - Encryption
################################################################################

resource "aws_opensearchserverless_security_policy" "encryption" {
  count = var.create && var.create_encryption_policy ? 1 : 0

  description = coalesce(var.encryption_security_policy_description, "Encryption policy for ${var.name} collection")
  name        = coalesce(var.encryption_security_policy_name, "${var.name}-encryption")
  policy = jsonencode(merge(
    {
      Rules = [
        {
          Resource     = ["collection/${var.name}"]
          ResourceType = "collection"
        }
      ]
      AWSOwnedKey = true
    },
    var.encryption_security_policy
  ))
  type = "encryption"
}

################################################################################
# Security Policy - Network
################################################################################

resource "aws_opensearchserverless_security_policy" "network" {
  count = var.create && var.create_network_policy ? 1 : 0

  description = coalesce(var.network_security_policy_description, "Newtwork policy for ${var.name} collection")
  name        = coalesce(var.network_security_policy_name, "${var.name}-network")
  policy = jsonencode(merge(
    {
      Rules = [
        {
          Resource     = ["collection/${var.name}"]
          ResourceType = "collection"
        }
      ]
      AllowFromPublic = true
    },
    var.network_security_policy
  ))
  type = "network"
}
