

# Create network
resource "openstack_networking_network_v2" "network" {
  name           = var.network_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.subnetwork_name
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr       = var.subnetwork_cidr
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = var.public_network_id
    depends_on = [openstack_networking_network_v2.network]
}


resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id =openstack_networking_subnet_v2.subnet.id
}


###Load Balancer

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = "loadbalance-307"
  vip_subnet_id = openstack_networking_subnet_v2.subnet.id
}

# Create listener
resource "openstack_lb_listener_v2" "http" {
  name            = "demo-lb1-http-listener"
  protocol        = "TCP"
  protocol_port   = 80
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
 
  insert_headers = {
    X-Forwarded-For = "true"
    X-Forwarded-Proto = "true"
  }
}
 
# Create pool
resource "openstack_lb_pool_v2" "http" {
  name        = "demo-lb1-http-pool1"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.http.id
}
 
# Add member to pool
resource "openstack_lb_member_v2" "http1" {
  count         = var.instance_count
  address       = openstack_compute_instance_v2.server-webserver[count.index].access_ip_v4
  protocol_port = 80
  pool_id       = openstack_lb_pool_v2.http.id
  subnet_id     = openstack_networking_subnet_v2.subnet.id
}