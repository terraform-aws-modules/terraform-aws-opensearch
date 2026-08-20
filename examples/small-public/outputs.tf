output "domain_arn" {
  description = "ARN of the OpenSearch domain."
  value       = module.opensearch.domain_arn
}

output "domain_name" {
  description = "Name of the OpenSearch domain."
  value       = module.opensearch.domain_name
}

output "domain_endpoint" {
  description = "HTTPS API endpoint for the OpenSearch domain."
  value       = "https://${module.opensearch.domain_endpoint}"
}

output "dashboard_url" {
  description = "URL for OpenSearch Dashboards."
  value       = "https://${module.opensearch.domain_dashboard_endpoint}"
}

output "application_id" {
  description = "Unique identifier of the managed OpenSearch UI application."
  value       = aws_opensearch_application.this.id
}

output "application_arn" {
  description = "ARN of the managed OpenSearch UI application."
  value       = aws_opensearch_application.this.arn
}

output "application_endpoint" {
  description = "Endpoint URL of the managed OpenSearch UI application."
  value       = aws_opensearch_application.this.endpoint
}