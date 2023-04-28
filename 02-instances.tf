
resource "openstack_networking_secgroup_v2" "web" {
  name        = "${var.course_code}web"
  description = "My security group for web connections"
}

resource "openstack_networking_secgroup_v2" "ssh" {
  name        = format("%s%s",var.course_code,"ssh")
  description = "My security group for ssh connections"
}


resource "openstack_networking_secgroup_rule_v2" "web_rules" {

  count = length(var.web_ports_open)

  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.web_ports_open[count.index]
  port_range_max    = var.web_ports_open[count.index]
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.web.id}"
  depends_on = [openstack_networking_secgroup_v2.web]
}

resource "openstack_networking_secgroup_rule_v2" "ssh_rules" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = "22"
  port_range_max = "22"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.ssh.id}"
  depends_on = [openstack_networking_secgroup_v2.ssh]
}


resource "openstack_compute_keypair_v2" "keypair" {
  name = "my-keypair"
}

#Create server

resource "openstack_compute_instance_v2" "server-webserver" {

  count = var.instance_count   

  image_id          = var.server_image_id
  flavor_id         = var.flavor_id
  key_pair          = openstack_compute_keypair_v2.keypair.name
  name              = "${var.server_name}-webserver-${count.index}"
#  security_groups   = ["${openstack_compute_secgroup_v2.ssh.id}"]
  security_groups   = [openstack_networking_secgroup_v2.ssh.name, openstack_networking_secgroup_v2.web.name]
  availability_zone = var.availability_zone
  depends_on = [
    openstack_networking_router_interface_v2.router_interface, openstack_networking_secgroup_v2.ssh, 
    openstack_networking_secgroup_v2.web
  ]
  network {
    name = openstack_networking_network_v2.network.name
  }
}