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

resource "cloudflare_access_policy" "github_policy" {
  application_id = cloudflare_access_application.application.id
  zone_id        = var.cloudflare_zone_id
  name           = "${var.name} GitHub Policy"
  precedence     = "1"
  decision       = "allow"
  include {
    github {
      name                 = var.github_org
      identity_provider_id = var.github_idp
      teams                = var.github_teams
    }
  }
  count = var.enable_managed_policy ? 1 : 0
}

resource "cloudflare_access_policy" "email_policy" {
  application_id = cloudflare_access_application.application.id
  zone_id        = var.cloudflare_zone_id
  name           = "${var.name} Email Policy"
  precedence     = "2"
  decision       = "allow"
  include { email = var.allowed_emails }
  count = length(var.allowed_emails) > 0 && var.enable_managed_policy ? 1 : 0
}