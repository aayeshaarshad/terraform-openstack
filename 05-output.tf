
#output variables
# output "webserver_server_public_ip" {
#   value = openstack_networking_floatingip_v2.ip-webserver.address
#   sensitive=false
# }


# resource "null_resource" "wait_ssh_webserver" {

#   connection {
#     type     = "ssh"
#     user     = "ubuntu"
#     private_key = openstack_compute_keypair_v2.keypair.private_key
#     host     = openstack_networking_floatingip_v2.ip-webserver.address
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "echo hello from `hostname`"
#     ]
#   }
#    depends_on = [openstack_compute_floatingip_associate_v2.server-webserver-ip, openstack_networking_router_interface_v2.router_interface]
# }


# resource "null_resource" "configure" {

#   depends_on = [
#                  openstack_compute_floatingip_associate_v2.server-ping-ip,
#                  openstack_compute_instance_v2.server-ping,
#                  null_resource.wait_ssh_ping, 
#                  null_resource.wait_ssh_webserver
#                  ]

# triggers = {
# #     always_run = "${timestamp()}"
#    }
#   # provisioner "local-exec" {
#   #   command = ". ./configure.sh ${openstack_networking_floatingip_v2.float_ip.address} ${var.identity_file}"

#   # }
# }


