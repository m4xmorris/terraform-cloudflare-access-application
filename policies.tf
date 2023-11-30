resource "cloudflare_access_policy" "github_policy" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} GitHub Policy"
  precedence                     = "1"
  decision                       = "allow"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    github {
      identity_provider_id = var.github_idp
      name                 = var.github_org
      teams                = var.github_teams
    }
  }
  count = length(flatten([var.device_policy_rules_windows, var.device_policy_rules_macos, var.device_policy_rules_ios, var.device_policy_rules_android])) == 0 ? 1 : 0
}

resource "cloudflare_access_policy" "device_policy_windows" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} Device Policy (Windows)"
  precedence                     = "1"
  decision       = "non_identity"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    device_posture = [var.gateway_device_rule_id]
  }
  require {
    device_posture = var.device_policy_rules_windows
  }
  count = length(var.device_policy_rules_windows) == 0 ? 0 : 1
}

resource "cloudflare_access_policy" "device_policy_macos" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} Device Policy (macOS)"
  precedence                     = "2"
  decision       = "non_identity"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    device_posture = [var.gateway_device_rule_id]
  }
  require {
    device_posture = var.device_policy_rules_macos
  }
  count = length(var.device_policy_rules_macos) == 0 ? 0 : 1
}

resource "cloudflare_access_policy" "device_policy_ios" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} Device Policy (iOS)"
  precedence                     = "3"
  decision       = "non_identity"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    device_posture = [var.gateway_device_rule_id]
  }
  require {
    device_posture = var.device_policy_rules_ios
  }
  count = length(var.device_policy_rules_ios) == 0 ? 0 : 1
}

resource "cloudflare_access_policy" "device_policy_android" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} Device Policy (Android)"
  precedence                     = "4"
  decision       = "non_identity"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    device_posture = [var.gateway_device_rule_id]
  }
  require {
    device_posture = var.device_policy_rules_windows
  }
  count = length(var.device_policy_rules_windows) == 0 ? 0 : 1
}

resource "cloudflare_access_policy" "email_policy" {
  application_id                 = cloudflare_access_application.application.id
  zone_id                        = var.cloudflare_zone_id
  name                           = "${var.name} Email Policy"
  precedence                     = "5"
  decision                       = "allow"
  purpose_justification_required = var.purpose_justification_required
  purpose_justification_prompt   = var.purpose_justification_required ? var.purpose_justification_prompt : null
  include {
    email = var.allowed_emails
  }
  count = length(var.allowed_emails) == 0 ? 0 : 1
}