
output "id" {
  value = linode_instance.primary.id
}

output "status" {
  value = linode_instance.primary.status
}

output "ipv4" {
  value = local.ipv4
}

output "ipv6" {
  value = local.ipv6
}

output "root_password" {
  sensitive = true
  value     = random_password.root_password
}

output "private_ssh_key" {
  sensitive = true
  value     = tls_private_key.ssh_key.private_key_pem
}
