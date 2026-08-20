variable "aws_region" {
  description = "AWS Region in which to create the OpenSearch domain."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI shared-configuration profile used by the AWS provider."
  type        = string
  default     = "Aaron"
}

variable "domain_name" {
  description = "Name of the OpenSearch domain."
  type        = string
  default     = "small-opensearch-test"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,27}$", var.domain_name))
    error_message = "domain_name must be 3-28 characters, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "application_name" {
  description = "Name of the managed OpenSearch UI application."
  type        = string
  default     = "small-opensearch-ui"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,29}$", var.application_name))
    error_message = "application_name must be 3-30 characters, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "engine_version" {
  description = "OpenSearch engine version supported in the selected AWS Region."
  type        = string
  default     = "OpenSearch_2.19"
}

variable "allowed_cidr" {
  description = "Public IPv4 CIDR allowed to reach the domain, normally your current public IP with a /32 suffix."
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_cidr, 0)) && can(regex("^[0-9.]+/[0-9]+$", var.allowed_cidr))
    error_message = "allowed_cidr must be a valid IPv4 CIDR, for example 203.0.113.10/32."
  }
}

variable "master_user_name" {
  description = "OpenSearch fine-grained access-control master username."
  type        = string
  default     = "opensearch_admin"
}

variable "master_user_password" {
  description = "OpenSearch master password. Supply it with TF_VAR_master_user_password; never commit it to Git."
  type        = string
  sensitive   = true

  validation {
    condition = (
      length(var.master_user_password) >= 8 &&
      can(regex("[A-Z]", var.master_user_password)) &&
      can(regex("[a-z]", var.master_user_password)) &&
      can(regex("[0-9]", var.master_user_password)) &&
      can(regex("[^A-Za-z0-9]", var.master_user_password))
    )
    error_message = "master_user_password must be at least 8 characters and contain uppercase, lowercase, numeric, and special characters."
  }
}