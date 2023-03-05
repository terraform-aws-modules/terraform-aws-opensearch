provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = basename(path.cwd)
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-opensearch"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# Opensearch Module
################################################################################

module "opensearch" {
  source = "../.."

  create = false

  tags = local.tags
}

module "opensearch_disabled" {
  source = "../.."

  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = false
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = local.tags
}
