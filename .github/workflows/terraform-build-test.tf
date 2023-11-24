terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "cloudflare" {
  api_token = "nullnullnullnullnullnullnullnullnullnull"
}

module "terraform_cloudflare_access_application" {
  source                = "../../"
  name                  = "build-test"
  logo                  = "http://example.com/example.png"
  domain                = "example.com"
  allowed_idps          = ["null"]
  cloudflare_account_id = "null"
  cloudflare_token      = "nullnullnullnullnullnullnullnullnullnull"
  cloudflare_zone_id    = "null"
  github_idp = "null"
  github_org = "Null"
  github_teams = [ "Null" ]
  allowed_emails = [ "" ]
}