
resource "random_password" "root_password" {
  length           = 16
  special          = true
  override_special = "_-%$@"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "linode_sshkey" "primary" {
  label   = "${var.label}-key"
  ssh_key = trimspace(tls_private_key.ssh_key.public_key_openssh)
}
