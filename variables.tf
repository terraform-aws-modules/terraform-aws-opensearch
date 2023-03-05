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
# Domain
################################################################################

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
  type        = string
  default     = null
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply"
  type        = map(string)
  default     = {}
}

variable "advanced_security_options" {
  description = "Configuration block for [fine-grained access control](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/fgac.html)"
  type        = any
  default     = {}
}

variable "auto_tune_options" {
  description = "Configuration block for the Auto-Tune options of the domain"
  type        = any
  default     = {}
}

variable "cluster_config" {
  description = "Configuration block for the cluster of the domain"
  type        = any
  default     = {}
}

variable "cognito_options" {
  description = "Configuration block for authenticating Kibana with Cognito"
  type        = any
  default     = {}
}

variable "domain_endpoint_options" {
  description = "Configuration block for domain endpoint HTTP(S) related options"
  type        = any
  default     = {}
}

variable "domain_name" {
  description = "Name of the domain"
  type        = string
  default     = ""
}

variable "ebs_options" {
  description = "Configuration block for EBS related options, may be required based on chosen [instance size](https://aws.amazon.com/elasticsearch-service/pricing/)"
  type        = any
  default     = {}
}

variable "encrypt_at_rest" {
  description = "Configuration block for encrypting at rest"
  type        = any
  default     = {}
}

variable "engine_version" {
  description = "Version of the OpenSearch engine to use"
  type        = string
  default     = "OpenSearch_2.3"
}

variable "log_publishing_options" {
  description = "Configuration block for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log_type, within the same resource"
  type        = any
  default     = []
}

variable "node_to_node_encryption" {
  description = "Configuration block for node-to-node encryption options"
  type        = any
  default     = {}
}

variable "vpc_options" {
  description = "Configuration block for VPC related options. Adding or removing this configuration forces a new resource ([documentation](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-vpc-limitations))"
  type        = any
  default     = {}
}
