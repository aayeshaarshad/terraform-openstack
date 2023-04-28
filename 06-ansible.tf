resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
     ips = openstack_networking_floatingip_v2.ip-webserver.*.address
    }
  )
  filename = var.ansible_inventory
  depends_on = [
    openstack_compute_instance_v2.server-webserver
  ]
}

resource "local_file" "private_key_file" {
  filename = var.key_pair_private_key
  content  = openstack_compute_keypair_v2.keypair.private_key
    depends_on = [
    openstack_compute_keypair_v2.keypair
  ]
}
