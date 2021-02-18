
variable "cloudflare_zone_id" {
  sensitive = true
  type      = string
}

variable "dns_record_name" {
  type    = string
  default = "vtt"
}

variable "dns_record_ttl" {
  type    = number
  default = 3600
}

variable "ipv4" {
  type = string
}

variable "ipv6" {
  type = string
}

variable "wait_seconds_for_dns_records" {
  type    = string
  default = "1m"
}
