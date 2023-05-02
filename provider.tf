

# Instructions from: https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
# Define the providers --> openstack in our case
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }

    #The following "local" is only necessary becasuse we add and later remove the local_file and null_resource in the .tf files during the demo
    #https://discuss.hashicorp.com/t/no-resource-schema-found-for-local-file-in-terraform-cloud/34561/3
    #https://robertdebock.nl/learn-terraform/ADVANCED/multiple-resources.html
    #https://stackoverflow.com/questions/61774501/multiple-provider-versions-with-terraform
    #https://stackoverflow.com/questions/70893369/terraform-error-missing-resource-schema-from-provider-no-resource-schema-fou
    local = {
      version = "~> 2.1"
    }
  }
}

#user_name, tenant, password, region taken from our environment variable after sourcing our RC file
# provider "openstack" {
#   auth_url    = "https://cscloud.lnu.se:5000/v3"
# }

provider "openstack" {
  use_octavia = true
  user_name   = "aa225zq-4me307"
  password    = ""
  auth_url    = "https://cscloud.lnu.se:5000/v3"

  #auth_url = "https://cscloud.lnu.se:5000"
  region           = "RegionOne"
  user_domain_name = "default"
  #tenant_name = "aa225zq-4me307-vt23"
  #tenant_id = "1bed87b36b5941f9a8cac39cc94fb63d"
}