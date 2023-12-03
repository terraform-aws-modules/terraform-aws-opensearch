################################################################################
# OpenSearch Collection
################################################################################

output "opensearch_collection_public_arn" {
  description = "Amazon Resource Name (ARN) of the collection"
  value       = module.opensearch_collection_public.arn
}

output "opensearch_collection_public_endpoint" {
  description = "Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection"
  value       = module.opensearch_collection_public.endpoint
}

output "opensearch_collection_public_dashboard_endpoint" {
  description = "Collection-specific endpoint used to access OpenSearch Dashboards"
  value       = module.opensearch_collection_public.dashboard_endpoint
}

output "opensearch_collection_public_kms_key_arn" {
  description = "The ARN of the Amazon Web Services KMS key used to encrypt the collection"
  value       = module.opensearch_collection_public.kms_key_arn
}

output "opensearch_collection_public_id" {
  description = "Unique identifier for the collection"
  value       = module.opensearch_collection_public.id
}

output "opensearch_collection_public_encryption_policy_version" {
  description = "The version of the encryption policy"
  value       = module.opensearch_collection_public.encryption_policy_version
}

output "opensearch_collection_public_encryption_policy" {
  description = "The JSON policy document of the encryption policy"
  value       = module.opensearch_collection_public.encryption_policy
}

output "opensearch_collection_public_network_policy_version" {
  description = "The version of the network policy"
  value       = module.opensearch_collection_public.network_policy_version
}

output "opensearch_collection_public_network_policy" {
  description = "The JSON policy document of the network policy"
  value       = module.opensearch_collection_public.network_policy
}

output "opensearch_collection_public_access_policy_version" {
  description = "The version of the access policy"
  value       = module.opensearch_collection_public.access_policy_version
}

output "opensearch_collection_public_access_policy" {
  description = "The JSON policy document of the access policy"
  value       = module.opensearch_collection_public.access_policy
}

output "opensearch_collection_public_lifecycle_policy_version" {
  description = "The version of the lifecycle policy"
  value       = module.opensearch_collection_public.lifecycle_policy_version
}

output "opensearch_collection_public_lifecycle_policy" {
  description = "The JSON policy document of the lifecycle policy"
  value       = module.opensearch_collection_public.lifecycle_policy
}

################################################################################
# OpenSearch Private Collection
################################################################################

output "opensearch_collection_private_arn" {
  description = "Amazon Resource Name (ARN) of the collection"
  value       = module.opensearch_collection_private.arn
}

output "opensearch_collection_private_endpoint" {
  description = "Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection"
  value       = module.opensearch_collection_private.endpoint
}

output "opensearch_collection_private_dashboard_endpoint" {
  description = "Collection-specific endpoint used to access OpenSearch Dashboards"
  value       = module.opensearch_collection_private.dashboard_endpoint
}

output "opensearch_collection_private_kms_key_arn" {
  description = "The ARN of the Amazon Web Services KMS key used to encrypt the collection"
  value       = module.opensearch_collection_private.kms_key_arn
}

output "opensearch_collection_private_id" {
  description = "Unique identifier for the collection"
  value       = module.opensearch_collection_private.id
}

output "opensearch_collection_private_encryption_policy_version" {
  description = "The version of the encryption policy"
  value       = module.opensearch_collection_private.encryption_policy_version
}

output "opensearch_collection_private_encryption_policy" {
  description = "The JSON policy document of the encryption policy"
  value       = module.opensearch_collection_private.encryption_policy
}

output "opensearch_collection_private_network_policy_version" {
  description = "The version of the network policy"
  value       = module.opensearch_collection_private.network_policy_version
}

output "opensearch_collection_private_network_policy" {
  description = "The JSON policy document of the network policy"
  value       = module.opensearch_collection_private.network_policy
}

output "opensearch_collection_private_access_policy_version" {
  description = "The version of the access policy"
  value       = module.opensearch_collection_private.access_policy_version
}

output "opensearch_collection_private_access_policy" {
  description = "The JSON policy document of the access policy"
  value       = module.opensearch_collection_private.access_policy
}

output "opensearch_collection_private_lifecycle_policy_version" {
  description = "The version of the lifecycle policy"
  value       = module.opensearch_collection_private.lifecycle_policy_version
}

output "opensearch_collection_private_lifecycle_policy" {
  description = "The JSON policy document of the lifecycle policy"
  value       = module.opensearch_collection_private.lifecycle_policy
}
