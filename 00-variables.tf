#Some variables 

variable "network_name" {
  type    = string
  default = "network4me307tf"
}

variable "subnetwork_name" {
  type    = string
  default = "subnet4me307tf"
}

variable "subnetwork_cidr" {
  type    = string
  default = "192.168.4.0/24"
}

variable "router_name" {
  type    = string
  default = "router4me307tf"
}

variable "public_network_id" {
  type    = string
  default = "fd401e50-9484-4883-9672-a2814089528c"
}

variable "key_name" {
  type    = string
  default = "my-keypair"
}


variable "flavor_id" {
  type    = string
  default = "c1-r1-d10"
}

variable "server_image_id" {
  type    = string
  default = "0e2d42aa-310c-4b3d-ae60-717d4e5fde53"
  description ="Ubuntu minimal 22.04.1"
}

variable "availability_zone" {
  type    = string
  default = "Education"
}


variable "instance_count" {
  default = "2"
}

variable "server_name" {
  type    = string
  default = "server4me307tf"
}

variable "loadbalancer_name" {
  type = string
  default = "loadBalancer4me307tf"
}

variable "ansible_inventory" {
  type    = string
  default =  "../ansible/inventory"
}

variable "key_pair_private_key" {
  type    = string
  default =  "../ansible/private_key_file"
}

variable "identity_file" {
  type    = string
  default = "Please export an environment variable TF_VAR_identity_file with the path to your key for ansible machine"
}  

# variable "apache_listening_port" {
#   type    = string
#   default = "8082"
# }

variable "web_ports_open" {
  description = "Ports to allow access on the machines. They conform a single security group"
  type        = list(string)
  default     = ["80", "8080", "8082"]
}

variable "course_code" {
  type    = string
  default = "4me307"
}