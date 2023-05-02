

# Create network
resource "openstack_networking_network_v2" "network" {
  name           = var.network_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.subnetwork_name
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.subnetwork_cidr
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = var.public_network_id
  depends_on          = [openstack_networking_network_v2.network]
}


resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

