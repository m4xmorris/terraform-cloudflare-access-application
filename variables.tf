variable "name" {
  type        = string
  description = "Name of the application"
}

variable "logo" {
  type        = string
  description = "Image URL to show in App Launcher"
  validation {
    condition     = can(regex("^https?://.*", var.logo))
    error_message = "The 'my_url' variable must be a valid URL starting with http:// or https://."
  }
}

variable "domain" {
  type        = string
  description = "FQDN for the application"
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.domain))
    error_message = "The 'my_domain' variable must be a valid domain name or subdomain."
  }
}

variable "type" {
  type        = string
  description = "Type of application"
  default     = "self_hosted"
}

variable "allowed_idps" {
  type        = list(string)
  description = "List of allowed identity providers"
}

variable "app_launcher_visible" {
  type        = bool
  description = "Whether the application is visible in the App Launcher"
  default     = true
}

variable "session_duration" {
  type        = string
  description = "Max duration of a session"
  validation {
    condition     = can(regex("^[0-9]+h([0-9]+m)?$", var.session_duration))
    error_message = "Time must be in the format '48h' or '2h45m'"
  }
  default = "12h"
}

variable "cloudflare_account_id" {
  type        = string
  sensitive   = true
  description = "Cloudflare Account ID"
}

variable "cloudflare_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API Token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "allow_conditions" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for the application"
}