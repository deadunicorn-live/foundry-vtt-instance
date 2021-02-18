terraform {
  required_version = "~> 0.14.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">=1.14.3,<1.15.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=2.18.0,<3.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.6.0,<0.7.0"
    }
  }
}
