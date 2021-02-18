variable "linode_token" {
  sensitive = true
  type      = string
}

variable "cloudflare_token" {
  sensitive = true
  type      = string
}

variable "domain" {
  type      = string
}

variable "label" {
  type = string
}

variable "region" {
  type = string
}

variable "dns_record_name" {
  type = string
}

variable "dns_record_ttl" {
  type = number
  default = null
}

variable "dns_cnames" {
  type = list(string)
  default = []
}
