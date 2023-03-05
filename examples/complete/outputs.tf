################################################################################
# Default
################################################################################

output "default_domain_arn" {
  description = "The Amazon Resource Name (ARN) of the domain"
  value       = module.opensearch_default.domain_arn
}

output "default_domain_id" {
  description = "The unique identifier for the domain"
  value       = module.opensearch_default.domain_id
}

output "default_domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = module.opensearch_default.domain_endpoint
}

output "default_domain_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = module.opensearch_default.domain_kibana_endpoint
}

output "default_cloudwatch_logs" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.opensearch_default.cloudwatch_logs
}

output "default_outbound_connections" {
  description = "Map of outbound connections created and their attributes"
  value       = module.opensearch_default.outbound_connections
}
