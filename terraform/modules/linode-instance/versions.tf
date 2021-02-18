terraform {
  required_version = "~> 0.14.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">=1.14.3,<1.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0.1,<4.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">=3.0.0,<4.0.0"
    }
  }
}
