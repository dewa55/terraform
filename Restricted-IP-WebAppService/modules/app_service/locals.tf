locals {

  default_site_config = {
    always_on = "true"
  }


  ip_restriction = [
    for cidr in var.authorized_ips : {
      name                      = lookup(cidr, "name", null)
      ip_address                = lookup(cidr, "ip", null)
      virtual_network_subnet_id = null
      service_tag               = null
      subnet_id                 = null
      priority                  = 10 + index(var.authorized_ips, cidr)
      action                    = "Allow"
      headers                   = null
    }
  ]
}
