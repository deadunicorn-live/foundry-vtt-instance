
locals {
  ipv4 = linode_instance.primary.ip_address
  ipv6 = trimsuffix(linode_instance.primary.ipv6, "/64")
}

data "linode_profile" "profile" {}

resource "linode_instance" "primary" {
  type   = var.instance_type
  image  = var.image
  region = var.region

  label = "${var.label}-instance"
  group = var.group
  tags  = var.tags

  authorized_keys  = [linode_sshkey.primary.ssh_key]
  authorized_users = [data.linode_profile.profile.username]
  root_pass        = random_password.root_password.result

  private_ip       = false
  backups_enabled  = var.enable_backup
  watchdog_enabled = var.enable_watchdog
}
