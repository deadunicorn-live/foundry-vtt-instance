
resource "cloudflare_record" "record_A" {
  zone_id = var.cloudflare_zone_id
  name    = var.dns_record_name
  value   = var.ipv4
  type    = "A"
  ttl     = var.dns_record_ttl
}

resource "cloudflare_record" "record_AAAA" {
  zone_id = var.cloudflare_zone_id
  name    = var.dns_record_name
  value   = var.ipv6
  type    = "AAAA"
  ttl     = var.dns_record_ttl
}

resource "time_sleep" "wait_on_dns_records" {
  depends_on = [
    cloudflare_record.record_A,
    cloudflare_record.record_AAAA
  ]

  create_duration = var.wait_seconds_for_dns_records
}

resource "linode_rdns" "rdns_A" {
  address = var.ipv4
  rdns    = cloudflare_record.record_A.hostname

  depends_on = [
    cloudflare_record.record_A,
    time_sleep.wait_on_dns_records
  ]
}

resource "linode_rdns" "rdns_AAAA" {
  address = var.ipv6
  rdns    = cloudflare_record.record_AAAA.hostname

  depends_on = [
    cloudflare_record.record_AAAA,
    time_sleep.wait_on_dns_records
  ]
}

