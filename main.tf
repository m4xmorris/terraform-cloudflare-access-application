terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_access_application" "application" {
  zone_id                   = var.cloudflare_zone_id
  name                      = var.name
  logo_url                  = var.logo
  domain                    = var.domain
  type                      = var.type
  allowed_idps              = var.allowed_idps
  app_launcher_visible      = var.app_launcher_visible
  session_duration          = var.session_duration
  auto_redirect_to_identity = false
}