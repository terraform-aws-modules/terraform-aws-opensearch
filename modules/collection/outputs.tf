################################################################################
# Collection
################################################################################

output "arn" {
  description = "Amazon Resource Name (ARN) of the collection"
  value       = try(aws_opensearchserverless_collection.this[0].arn, null)
}

output "endpoint" {
  description = "Collection-specific endpoint used to submit index, search, and data upload requests to an OpenSearch Serverless collection"
  value       = try(aws_opensearchserverless_collection.this[0].collection_endpoint, null)
}

output "dashboard_endpoint" {
  description = "Collection-specific endpoint used to access OpenSearch Dashboards"
  value       = try(aws_opensearchserverless_collection.this[0].dashboard_endpoint, null)
}

output "kms_key_arn" {
  description = "The ARN of the Amazon Web Services KMS key used to encrypt the collection"
  value       = try(aws_opensearchserverless_collection.this[0].kms_key_arn, null)
}

output "id" {
  description = "Unique identifier for the collection"
  value       = try(aws_opensearchserverless_collection.this[0].id, null)
}

################################################################################
# Encryption Policy
################################################################################

output "encryption_policy_version" {
  description = "The version of the encryption policy"
  value       = try(aws_opensearchserverless_security_policy.encryption[0].policy_version, null)
}

output "encryption_policy" {
  description = "The JSON policy document of the encryption policy"
  value       = try(aws_opensearchserverless_security_policy.encryption[0].policy, null)
}

################################################################################
# Network Policy
################################################################################

output "network_policy_version" {
  description = "The version of the network policy"
  value       = try(aws_opensearchserverless_security_policy.network[0].policy_version, null)
}

output "network_policy" {
  description = "The JSON policy document of the network policy"
  value       = try(aws_opensearchserverless_security_policy.network[0].policy, null)
}

################################################################################
# Access Policy
################################################################################

output "access_policy_version" {
  description = "The version of the access policy"
  value       = try(aws_opensearchserverless_access_policy.this[0].policy_version, null)
}

output "access_policy" {
  description = "The JSON policy document of the access policy"
  value       = try(aws_opensearchserverless_access_policy.this[0].policy, null)
}

################################################################################
# Lifecycle Policy
################################################################################

output "lifecycle_policy_version" {
  description = "The version of the lifecycle policy"
  value       = try(aws_opensearchserverless_lifecycle_policy.this[0].policy_version, null)
}

output "lifecycle_policy" {
  description = "The JSON policy document of the lifecycle policy"
  value       = try(aws_opensearchserverless_lifecycle_policy.this[0].policy, null)
}
