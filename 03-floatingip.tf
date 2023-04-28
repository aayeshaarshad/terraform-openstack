resource "openstack_networking_floatingip_v2" "ip-webserver" {
  count = var.instance_count 
  pool = "public"
}


# associate public IP
resource "openstack_compute_floatingip_associate_v2" "server-webserver-ip" {
  count = var.instance_count 
  floating_ip = openstack_networking_floatingip_v2.ip-webserver[count.index].address
  instance_id = openstack_compute_instance_v2.server-webserver[count.index].id
  depends_on = [
    openstack_compute_instance_v2.server-webserver, openstack_networking_floatingip_v2.ip-webserver
  ]
}

resource "openstack_networking_floatingip_v2" "load-balance-fip" {
  pool = "public"
}

resource "openstack_networking_floatingip_associate_v2" "load-balancer-ip" {
  floating_ip = openstack_networking_floatingip_v2.load-balance-fip.address
  port_id = openstack_lb_loadbalancer_v2.lb.vip_port_id
}