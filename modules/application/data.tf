data "aws_caller_identity" "current" {
  count = var.create && var.identity_center.enabled && var.identity_center.create_role ? 1 : 0
}

data "aws_partition" "current" {
  count = var.create && var.identity_center.enabled && var.identity_center.create_role ? 1 : 0
}

data "aws_region" "current" {
  count = var.create && var.identity_center.enabled && var.identity_center.create_role ? 1 : 0

  region = var.region
}