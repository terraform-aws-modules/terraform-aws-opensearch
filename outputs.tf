################################################################################
# Domain
################################################################################

output "domain_arn" {
  description = "The Amazon Resource Name (ARN) of the domain"
  value       = try(aws_opensearch_domain.this[0].arn, null)
}

output "domain_id" {
  description = "The unique identifier for the domain"
  value       = try(aws_opensearch_domain.this[0].domain_id, null)
}

output "domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = try(aws_opensearch_domain.this[0].endpoint, null)
}

output "domain_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = try(aws_opensearch_domain.this[0].kibana_endpoint, null)
}
