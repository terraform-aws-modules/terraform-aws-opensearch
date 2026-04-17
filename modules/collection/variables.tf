variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where this resource will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Collection Group
################################################################################

variable "collection_group_capacity_limits_max_indexing_capacity_in_ocu" {
  description = "Maximum indexing capacity in OCU for the collection group"
  type        = number
  default     = 1
}

variable "collection_group_capacity_limits_max_search_capacity_in_ocu" {
  description = "Maximum search capacity in OCU for the collection group"
  type        = number
  default     = 96
}

variable "collection_group_capacity_limits_min_indexing_capacity_in_ocu" {
  description = "Minimum indexing capacity in OCU for the collection group"
  type        = number
  default     = 1
}

variable "collection_group_capacity_limits_min_search_capacity_in_ocu" {
  description = "Minimum search capacity in OCU for the collection group"
  type        = number
  default     = 96
}

variable "collection_group_description" {
  description = "Description of the collection group"
  type        = string
  default     = ""
}

variable "collection_group_name" {
  description = "Name of the collection group"
  type        = string
  default     = ""
}

variable "collection_group_standby_replicas" {
  description = "Indicates whether standby replicas should be used for the collection group. Valid values are `ENABLED` and `DISABLED`"
  type        = string
  default     = "ENABLED"

  validation {
    condition     = var.collection_group_standby_replicas == null || contains(["ENABLED", "DISABLED"], var.collection_group_standby_replicas)
    error_message = "Valid values for collection_group_standby_replicas are `ENABLED` and `DISABLED`."
  }
}

variable "create_collection_group" {
  description = "Determines if a collection group is created"
  type        = bool
  default     = false
}

################################################################################
# Collection
################################################################################

variable "description" {
  description = "Description of the collection"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the collection"
  type        = string
  default     = ""
}

variable "type" {
  description = "Type of collection. One of `SEARCH`, `TIMESERIES`, or `VECTORSEARCH`. Defaults to `TIMESERIES`"
  type        = string
  default     = null
}

variable "standby_replicas" {
  description = "Indicates whether standby replicas should be used for a collection. One of ENABLED or DISABLED. Defaults to ENABLED."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Create and delete timeout configurations for the collection"
  type        = map(string)
  default     = {}
}

################################################################################
# Encryption Policy
################################################################################

variable "create_encryption_policy" {
  description = "Determines whether an encryption policy will be created"
  type        = bool
  default     = true
}

variable "encryption_policy_description" {
  description = "Description of the encryption policy"
  type        = string
  default     = null
}

variable "encryption_policy_name" {
  description = "Name of the encryption policy"
  type        = string
  default     = null
}

variable "encryption_policy" {
  description = "Encryption policy to apply to the collection"
  type        = any
  default     = {}
}

################################################################################
# Network Policy
################################################################################

variable "create_network_policy" {
  description = "Determines whether an network policy will be created"
  type        = bool
  default     = false
}

variable "network_policy_description" {
  description = "Description of the network policy"
  type        = string
  default     = null
}

variable "network_policy_name" {
  description = "Name of the network policy"
  type        = string
  default     = null
}

variable "network_policy" {
  description = "Network policy to apply to the collection"
  type        = any
  default     = {}
}

################################################################################
# Access Policy
################################################################################

variable "create_access_policy" {
  description = "Determines whether an access policy will be created"
  type        = bool
  default     = false
}

variable "access_policy_description" {
  description = "Description of the access policy"
  type        = string
  default     = null
}

variable "access_policy_name" {
  description = "Name of the access policy"
  type        = string
  default     = null
}

variable "access_policy_index_permissions" {
  description = "Access policy permissions for the collection index"
  type        = list(string)
  default     = ["aoss:*"]
}

variable "access_policy_collection_permissions" {
  description = "Access policy permissions for the collection"
  type        = list(string)
  default     = ["aoss:*"]
}

variable "access_policy_principals" {
  description = "Access policy principals"
  type        = list(string)
  default     = []
}

variable "access_policy" {
  description = "Access policy to apply to the collection"
  type        = any
  default     = {}
}

################################################################################
# Lifecycle Policy
################################################################################

variable "create_lifecycle_policy" {
  description = "Determines whether an lifecycle policy will be created"
  type        = bool
  default     = false
}

variable "lifecycle_policy_description" {
  description = "Description of the lifecycle policy"
  type        = string
  default     = null
}

variable "lifecycle_policy_name" {
  description = "Name of the lifecycle policy"
  type        = string
  default     = null
}

variable "lifecycle_policy_min_index_retention" {
  description = "The minimum period, in days (d) or hours (h), to retain the document in the index. The lower bound is `24h` and the upper bound is `3650d`"
  type        = string
  default     = null
}

variable "lifecycle_policy_no_min_index_retention" {
  description = "If true, OpenSearch Serverless retains documents indefinitely"
  type        = bool
  default     = null
}
