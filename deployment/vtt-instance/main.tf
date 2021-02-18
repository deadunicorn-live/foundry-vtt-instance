
terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    linode = {
      source = "linode/linode"
    }
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "linode" {
  token = var.linode_token
}

data "cloudflare_zones" "primary" {
  filter {
    name = var.domain
    lookup_type = "exact"
  }
}

module "instance" {
  source = "../../terraform/modules/linode-instance"

  region = var.region
  label  = var.label
}

module "dns_record" {
  source = "../../terraform/modules/cloudflare-record"

  cloudflare_zone_id = data.cloudflare_zones.primary.zones[0].id

  dns_record_name = var.dns_record_name
  dns_record_ttl = var.dns_record_ttl

  ipv4 = module.instance.ipv4
  ipv6 = module.instance.ipv6
}

resource "local_file" "ssh_key_file" {
  sensitive_content = module.instance.private_ssh_key
  filename = "${path.module}/ssh_rsa.key"
  file_permission = 0700
}

resource "null_resource" "provision" {
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      host = module.instance.ipv4
      private_key = module.instance.private_ssh_key
    }

    inline = [
      "which python3 || apt-get update; apt-get -y install --no-install-recommends python3",
    ]
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -i '${module.instance.ipv4},' --private-key ./ssh_rsa.key ../../ansible/site.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  depends_on = [local_file.ssh_key_file]
}
