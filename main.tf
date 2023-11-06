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

resource "cloudflare_access_policy" "policy" {
  application_id = cloudflare_access_application.application.id
  zone_id        = var.cloudflare_zone_id
  name           = "Allow Policy"
  precedence     = "1"
  decision       = "allow"
  dynamic "include" {
    for_each = var.allow_conditions
    content {
      email = include.value.email

      github {
        name                 = include.value.github.name
      }
    }
  }
}