

output "id" {
  value = module.instance.id
}

output "status" {
  value = module.instance.status
}

output "root_password" {
  sensitive = true
  value     = module.instance.root_password
}

output "ssh_key" {
  sensitive = true
  value     = module.instance.private_ssh_key
}

# output "dns_record" {
#   value = module.dns_record.dns_record
# }

output "ipv4" {
  value = module.instance.ipv4
}

output "ipv6" {
  value = module.instance.ipv6
}
