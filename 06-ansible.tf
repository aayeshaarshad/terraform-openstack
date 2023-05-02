resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      ips            = openstack_networking_floatingip_v2.ip-webserver.*.address
      loadbalancerip = openstack_networking_floatingip_v2.load-balance-ip.address
    }
  )
  filename = var.ansible_inventory
  depends_on = [
    openstack_compute_instance_v2.server-webserver,
    openstack_compute_instance_v2.server-loadbalancer
  ]
}

resource "local_file" "nginx-cfg" {
  content = templatefile(var.ansible_nginx_cfg_tmpl,
    {
      ips = openstack_networking_floatingip_v2.ip-webserver.*.address
    }
  )
  filename = var.ansible_nginx_cfg
  depends_on = [
    openstack_compute_instance_v2.server-webserver,
    openstack_compute_instance_v2.server-loadbalancer
  ]
}

resource "local_file" "private_key_file" {
  filename = var.key_pair_private_key
  content  = openstack_compute_keypair_v2.keypair.private_key
  depends_on = [
    openstack_compute_keypair_v2.keypair
  ]
}
