variable "create" {
  description = "Whether to create the OpenSearch application and supporting IAM resources."
  type        = bool
  default     = true
}

variable "name" {
  description = "Unique name of the OpenSearch application in the AWS account and Region."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,29}$", var.name))
    error_message = "name must be 3-30 characters, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "data_sources" {
  description = "OpenSearch domains or collections to associate with the application. Map keys are stable Terraform identifiers."
  type = map(object({
    arn         = string
    description = optional(string)
  }))

  validation {
    condition     = alltrue([for source in values(var.data_sources) : length(source.arn) >= 20 && length(source.arn) <= 2048])
    error_message = "Each data source ARN must contain between 20 and 2048 characters."
  }
}

variable "identity_center" {
  description = "IAM Identity Center integration. Set create_role to false and supply role_arn to use an externally managed role."
  type = object({
    enabled      = optional(bool, false)
    instance_arn = optional(string)
    create_role  = optional(bool, true)
    role_arn     = optional(string)
    role_name    = optional(string)
  })
  default = {}

  validation {
    condition = (
      !var.identity_center.enabled ||
      (
        var.identity_center.instance_arn != null &&
        (var.identity_center.create_role || var.identity_center.role_arn != null)
      )
    )
    error_message = "When Identity Center is enabled, instance_arn is required and either create_role must be true or role_arn must be supplied."
  }
}

variable "dashboard_admin_user_ids" {
  description = "IAM Identity Center user IDs granted OpenSearch Dashboards administrator access."
  type        = list(string)
  default     = []
}

variable "dashboard_admin_group_ids" {
  description = "IAM Identity Center group IDs granted OpenSearch Dashboards administrator access."
  type        = list(string)
  default     = []
}

variable "additional_app_config" {
  description = "Additional application configuration keyed by an AWS-supported OpenSearch application setting."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN used to encrypt application data at rest."
  type        = string
  default     = null
}

variable "region" {
  description = "Region where the application is managed. Defaults to the AWS provider Region."
  type        = string
  default     = null
}

variable "data_source_ready_delay" {
  description = "Optional delay after data source ARNs become available before creating the application. A new domain can require additional AWS propagation time."
  type        = string
  default     = "0s"

  validation {
    condition     = can(regex("^[0-9]+(s|m|h)$", var.data_source_ready_delay))
    error_message = "data_source_ready_delay must be a duration such as 0s, 2m, or 1h."
  }
}

variable "tags" {
  description = "Tags to assign to the application and module-managed IAM role."
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Create, update, and delete timeout values for the OpenSearch application."
  type        = map(string)
  default     = {}
}