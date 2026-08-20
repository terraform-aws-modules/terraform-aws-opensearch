locals {
  create_identity_center_role = var.create && var.identity_center.enabled && var.identity_center.create_role
  identity_center_role_name   = coalesce(var.identity_center.role_name, "${var.name}-identity-center")
}

data "aws_iam_policy_document" "identity_center_assume_role" {
  count = local.create_identity_center_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application.opensearchservice.amazonaws.com"]
    }
  }

  statement {
    actions = ["sts:SetContext"]

    principals {
      type        = "Service"
      identifiers = ["application.opensearchservice.amazonaws.com"]
    }

    condition {
      test     = "ForAllValues:ArnEquals"
      variable = "sts:RequestContextProviders"
      values = [
        "arn:${data.aws_partition.current[0].partition}:iam::${data.aws_caller_identity.current[0].account_id}:oidc-provider/portal.sso.${data.aws_region.current[0].region}.amazonaws.com/apl/*"
      ]
    }
  }
}

resource "aws_iam_role" "identity_center" {
  count = local.create_identity_center_role ? 1 : 0

  name               = local.identity_center_role_name
  assume_role_policy = data.aws_iam_policy_document.identity_center_assume_role[0].json

  tags = var.tags
}

data "aws_iam_policy_document" "identity_center_permissions" {
  count = local.create_identity_center_role ? 1 : 0

  statement {
    sid = "IdentityStoreOpenSearchConnectivity"
    actions = [
      "identitystore:DescribeGroup",
      "identitystore:DescribeUser",
      "identitystore:ListGroupMembershipsForMember",
    ]
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:CalledViaLast"
      values   = ["es.amazonaws.com"]
    }
  }

  statement {
    sid       = "OpenSearchDomainAccess"
    actions   = ["es:ESHttp*"]
    resources = ["*"]
  }

  statement {
    sid       = "OpenSearchServerlessAccess"
    actions   = ["aoss:APIAccessAll"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "identity_center" {
  count = local.create_identity_center_role ? 1 : 0

  name   = "${var.name}-identity-center"
  role   = aws_iam_role.identity_center[0].id
  policy = data.aws_iam_policy_document.identity_center_permissions[0].json
}