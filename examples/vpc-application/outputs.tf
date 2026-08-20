output "domain_arn" {
  description = "ARN of the VPC OpenSearch domain."
  value       = module.opensearch.domain_arn
}

output "domain_endpoint" {
  description = "Private endpoint of the VPC OpenSearch domain."
  value       = module.opensearch.domain_endpoint
}

output "application_id" {
  description = "ID of the OpenSearch UI application."
  value       = module.opensearch_ui.id
}

output "application_arn" {
  description = "ARN of the OpenSearch UI application."
  value       = module.opensearch_ui.arn
}

output "application_endpoint" {
  description = "Endpoint URL of the OpenSearch UI application."
  value       = module.opensearch_ui.endpoint
}

output "iam_identity_center_application_arn" {
  description = "ARN of the generated IAM Identity Center application."
  value       = module.opensearch_ui.iam_identity_center_application_arn
}

output "identity_center_role_arn" {
  description = "ARN of the role used by the OpenSearch UI application."
  value       = module.opensearch_ui.identity_center_role_arn
}