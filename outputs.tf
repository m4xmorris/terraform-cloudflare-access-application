output "aud" {
  value       = cloudflare_access_application.application.aud
  description = "Application Audience (AUD) Tag of the application"
}

output "id" {
  value       = cloudflare_access_application.application.id
  description = "ID of the application"
}
