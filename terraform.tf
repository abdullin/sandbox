// https://medium.com/@orestovyevhen/set-up-infrastructure-in-hetzner-cloud-using-terraform-ce85491e92d
//https://codeberg.org/Lenny/owncast-terraform-hetzner/src/branch/main/main.tf

terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.36.2"
    }
  }
}

provider "hcloud" { }

resource "hcloud_ssh_key" "default" {
  name       = "Terraform key"
  public_key = file("~/.ssh/id_ed25519.pub")
}


resource "hcloud_server" "streaming" {
  name        = "streaming"
  image       = "debian-11"
  server_type = "cx11"
  location    = "fsn1"

  ssh_keys    = [hcloud_ssh_key.default.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = file("user_data.yml")
}

output "instance_ip" {
  value = hcloud_server.streaming.ipv4_address
}
