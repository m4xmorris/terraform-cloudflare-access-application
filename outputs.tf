output "aud" {
  value       = cloudflare_access_application.application.aud
  description = "Application Audience (AUD) Tag of the application"
}

output "id" {
  value       = cloudflare_access_application.application.id
  description = "ID of the application"
}

locals {
  device_policy_rules_empty = length(flatten([var.device_policy_rules_windows, var.device_policy_rules_macos, var.device_policy_rules_ios, var.device_policy_rules_android])) == 0
}

output "github_policy_id" {
  value       = local.device_policy_rules_empty ? cloudflare_access_policy.github_policy[0].id : null
  description = "ID of the GitHub policy, if it exists"
}

output "device_policy_windows_id" {
  value       = local.device_policy_rules_empty ? null : cloudflare_access_policy.device_policy_windows[0].id
  description = "ID of the Device Policy (Windows)"
}

output "device_policy_macos_id" {
  value       = local.device_policy_rules_empty ? null : cloudflare_access_policy.device_policy_macos[0].id
  description = "ID of the Device Policy (macOS)"
}

output "device_policy_ios_id" {
  value       = local.device_policy_rules_empty ? null : cloudflare_access_policy.device_policy_ios[0].id
  description = "ID of the Device Policy (iOS)"
}

output "device_policy_android_id" {
  value       = local.device_policy_rules_empty ? null : cloudflare_access_policy.device_policy_android[0].id
  description = "ID of the Device Policy (Android)"
}