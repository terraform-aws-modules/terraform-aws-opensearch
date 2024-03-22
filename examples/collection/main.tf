provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-opensearch"
  }
}

################################################################################
# OpenSearch Module
################################################################################

module "opensearch_collection_public" {
  source = "../../modules/collection"

  name             = "${local.name}-public"
  description      = "Example public OpenSearch Serverless collection"
  type             = "SEARCH"
  standby_replicas = "DISABLED"

  create_access_policy  = true
  create_network_policy = true

  tags = local.tags
}

module "opensearch_collection_private" {
  source = "../../modules/collection"

  name        = "${local.name}-private"
  description = "Example private OpenSearch Serverless collection"
  type        = "SEARCH"

  create_access_policy  = true
  create_network_policy = true
  network_policy = {
    AllowFromPublic = false
    SourceVPCEs = [
      aws_opensearchserverless_vpc_endpoint.example.id
    ]
  }

  tags = local.tags
}

module "opensearch_collection_disabled" {
  source = "../../modules/collection"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  tags = local.tags
}

resource "aws_opensearchserverless_vpc_endpoint" "example" {
  name       = local.name
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id
}
