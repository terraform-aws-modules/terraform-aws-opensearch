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
# Security Policy - Encryption
################################################################################

variable "create_encryption_policy" {
  description = "Determines whether an encryption policy will be created"
  type        = bool
  default     = true
}

variable "encryption_security_policy_description" {
  description = "Description of the encryption security policy"
  type        = string
  default     = null
}

variable "encryption_security_policy_name" {
  description = "Name of the encryption security policy"
  type        = string
  default     = null
}

variable "encryption_security_policy" {
  description = "Encryption security policy to apply to the collection - this is merged with the default policy provided"
  type        = any
  default     = {}
}

################################################################################
# Security Policy - Network
################################################################################

variable "create_network_policy" {
  description = "Determines whether an network policy will be created"
  type        = bool
  default     = true
}

variable "network_security_policy_description" {
  description = "Description of the network security policy"
  type        = string
  default     = null
}

variable "network_security_policy_name" {
  description = "Name of the network security policy"
  type        = string
  default     = null
}

variable "network_security_policy" {
  description = "Network security policy to apply to the collection - this is merged with the default policy provided"
  type        = any
  default     = {}
}
