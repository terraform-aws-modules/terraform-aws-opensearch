data "aws_caller_identity" "current" {
  count = var.create ? 1 : 0
}

locals {
  tags = merge(var.tags, { terraform-aws-modules = "opensearch" })
}

################################################################################
# Collection
################################################################################

resource "aws_opensearchserverless_collection" "this" {
  count = var.create ? 1 : 0

  description      = var.description
  name             = var.name
  type             = var.type
  standby_replicas = var.standby_replicas

  tags = local.tags

  timeouts {
    create = try(var.timeouts.delete, null)
    delete = try(var.timeouts.delete, null)
  }

  depends_on = [
    aws_opensearchserverless_security_policy.encryption,
    aws_opensearchserverless_security_policy.network,
    aws_opensearchserverless_access_policy.this,
  ]
}

################################################################################
# Encryption Policy
################################################################################

resource "aws_opensearchserverless_security_policy" "encryption" {
  count = var.create && var.create_encryption_policy ? 1 : 0

  description = coalesce(var.encryption_policy_description, "Encryption policy for ${var.name} collection")
  name        = coalesce(var.encryption_policy_name, "${var.name}-encryption")
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
    var.encryption_policy
  ))

  type = "encryption"
}

################################################################################
# Network Policy
################################################################################

resource "aws_opensearchserverless_security_policy" "network" {
  count = var.create && var.create_network_policy ? 1 : 0

  description = coalesce(var.network_policy_description, "Newtwork policy for ${var.name} collection")
  name        = coalesce(var.network_policy_name, "${var.name}-network")
  policy = jsonencode([merge(
    {
      Rules = [
        {
          Resource     = ["collection/${var.name}"]
          ResourceType = "collection"
        },
        {
          Resource     = ["collection/${var.name}"]
          ResourceType = "dashboard"
        }
      ]
      AllowFromPublic = true
    },
    var.network_policy
  )])

  type = "network"
}

################################################################################
# Access Policy
################################################################################

resource "aws_opensearchserverless_access_policy" "this" {
  count = var.create && var.create_access_policy ? 1 : 0

  description = coalesce(var.access_policy_description, "Access policy for ${var.name} collection")
  name        = coalesce(var.access_policy_name, "${var.name}-access")
  policy = jsonencode([merge(
    {
      Rules = [
        {
          ResourceType = "index",
          Resource     = ["index/${var.name}/*"],
          Permission   = var.access_policy_index_permissions,
        },
        {
          ResourceType = "collection",
          Resource     = ["collection/${var.name}"],
          Permission   = var.access_policy_collection_permissions,
        }
      ],
      Principal = coalescelist(var.access_policy_principals, [data.aws_caller_identity.current[0].arn])
    },
    var.access_policy
  )])
  type = "data"
}

################################################################################
# Lifecycle Policy
################################################################################

resource "aws_opensearchserverless_lifecycle_policy" "this" {
  count = var.create && var.create_lifecycle_policy ? 1 : 0

  description = coalesce(var.lifecycle_policy_description, "Lifecycle policy for ${var.name} collection")
  name        = coalesce(var.lifecycle_policy_name, "${var.name}-lifecycle")
  policy = jsonencode(
    {
      Rules = [
        { for k, v in {
          Resource            = ["collection/${var.name}"]
          ResourceType        = "collection"
          MinIndexRetention   = var.lifecycle_policy_min_index_retention
          NoMinIndexRetention = var.lifecycle_policy_no_min_index_retention
          }
        : k => v if v != null }
      ]
    }
  )
  type = "retention"
}
