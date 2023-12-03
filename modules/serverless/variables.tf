variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
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
  default     = true
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
  default     = true
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

variable "access_policy" {
  description = "access policy to apply to the collection"
  type        = any
  default     = {}
}
