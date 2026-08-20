variable "aws_region" {
  description = "AWS Region in which to create the isolated test environment."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS shared-configuration profile used by the provider."
  type        = string
  default     = "Aaron"
}

variable "name_prefix" {
  description = "Prefix used for test resource names."
  type        = string
  default     = "vpc-ui-poc"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR for the isolated test VPC."
  type        = string
  default     = "10.42.0.0/16"
}

variable "engine_version" {
  description = "OpenSearch engine version supported by the selected Region."
  type        = string
  default     = "OpenSearch_2.19"
}

variable "master_user_password" {
  description = "Fine-grained access-control master password. Supply through TF_VAR_master_user_password."
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

variable "dashboard_admin_user_ids" {
  description = "IAM Identity Center user IDs assigned as dashboard administrators."
  type        = list(string)
  default     = []
}

variable "dashboard_admin_group_ids" {
  description = "IAM Identity Center group IDs assigned as dashboard administrators."
  type        = list(string)
  default     = []
}