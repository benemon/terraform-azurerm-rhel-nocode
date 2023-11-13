resource "azurerm_lb" "rhel" {
  name                = "${local.vm_name}-lb"
  sku                 = "Standard"
  location            = data.azurerm_resource_group.compute_rg.location
  resource_group_name = data.azurerm_resource_group.compute_rg.name

  frontend_ip_configuration {
    name                 = "${local.vm_name}-lb-public-ip"
    public_ip_address_id = azurerm_public_ip.rhel.id
  }

  tags = local.resource_tags
}

resource "azurerm_lb_backend_address_pool" "rhel" {
  loadbalancer_id = azurerm_lb.rhel.id
  name            = "${local.vm_name}-web-address-pool"
}

resource "azurerm_lb_backend_address_pool" "ssh" {
  loadbalancer_id = azurerm_lb.rhel.id
  name            = "${local.vm_name}-ssh-address-pool"
}

locals {
  element_zero_if = element(azurerm_network_interface.rhel.*, 0)
  lb_ip_conf      = element(azurerm_lb.rhel.frontend_ip_configuration.*, 0)
}

resource "azurerm_lb_backend_address_pool_address" "rhel" {
  count                   = var.vm_instance_count
  name                    = "${local.vm_name}-${count.index}-web-pool-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.rhel.id
  ip_address              = azurerm_network_interface.rhel[count.index].private_ip_address
  virtual_network_id      = data.azurerm_virtual_network.compute_vn.id
}

resource "azurerm_lb_backend_address_pool_address" "ssh" {
  name                    = "${local.vm_name}-ssh-pool-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ssh.id
  ip_address              = local.element_zero_if.private_ip_address
  virtual_network_id      = data.azurerm_virtual_network.compute_vn.id
}

resource "azurerm_network_interface_security_group_association" "rhel" {
  count                     = var.vm_instance_count
  network_interface_id      = azurerm_network_interface.rhel[count.index].id
  network_security_group_id = azurerm_network_security_group.rhel.id
}

resource "azurerm_network_security_group" "rhel" {
  name                = "${local.vm_name}-nsg"
  location            = data.azurerm_resource_group.compute_rg.location
  resource_group_name = data.azurerm_resource_group.compute_rg.name

  tags = local.resource_tags
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "${local.vm_name}-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.compute_rg.name
  network_security_group_name = azurerm_network_security_group.rhel.name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "${local.vm_name}-http"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.compute_rg.name
  network_security_group_name = azurerm_network_security_group.rhel.name
}

resource "azurerm_network_security_rule" "https" {
  name                        = "${local.vm_name}-https"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.compute_rg.name
  network_security_group_name = azurerm_network_security_group.rhel.name
}

resource "azurerm_lb_nat_rule" "ssh" {
  backend_port                   = 22
  enable_floating_ip             = false
  enable_tcp_reset               = false
  frontend_ip_configuration_name = local.lb_ip_conf.name
  frontend_port_start            = 22
  frontend_port_end              = 22
  idle_timeout_in_minutes        = 4
  loadbalancer_id                = azurerm_lb.rhel.id
  name                           = "InboundSSH"
  protocol                       = "Tcp"
  resource_group_name            = data.azurerm_resource_group.compute_rg.name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.ssh.id
}

resource "azurerm_lb_rule" "https" {
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.rhel.id]
  backend_port                   = 443
  disable_outbound_snat          = true
  enable_floating_ip             = false
  enable_tcp_reset               = false
  frontend_ip_configuration_name = local.lb_ip_conf.name
  frontend_port                  = 443
  idle_timeout_in_minutes        = 4
  load_distribution              = "SourceIPProtocol"
  loadbalancer_id                = azurerm_lb.rhel.id
  name                           = "InboundHTTPS"
  probe_id                       = azurerm_lb_probe.readiness-https.id
  protocol                       = "Tcp"
}

resource "azurerm_lb_rule" "http" {

  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.rhel.id]
  backend_port                   = 80
  disable_outbound_snat          = true
  enable_floating_ip             = false
  enable_tcp_reset               = false
  frontend_ip_configuration_name = local.lb_ip_conf.name
  frontend_port                  = 80
  idle_timeout_in_minutes        = 4
  load_distribution              = "SourceIPProtocol"
  loadbalancer_id                = azurerm_lb.rhel.id
  name                           = "InboundHTTP"
  probe_id                       = azurerm_lb_probe.readiness-http.id
  protocol                       = "Tcp"
}

resource "azurerm_lb_outbound_rule" "rhel" {
  allocated_outbound_ports = 63992
  backend_address_pool_id  = azurerm_lb_backend_address_pool.rhel.id
  enable_tcp_reset         = true
  idle_timeout_in_minutes  = 4
  loadbalancer_id          = azurerm_lb.rhel.id
  name                     = "OutboundAll"
  protocol                 = "All"
  frontend_ip_configuration {
    name = local.lb_ip_conf.name
  }
}

resource "azurerm_lb_probe" "readiness-https" {
  interval_in_seconds = 5
  loadbalancer_id     = azurerm_lb.rhel.id
  name                = "readiness-https"
  number_of_probes    = 1
  port                = 443
  probe_threshold     = 1
  protocol            = "Tcp"
  request_path        = null
}

resource "azurerm_lb_probe" "readiness-http" {
  interval_in_seconds = 5
  loadbalancer_id     = azurerm_lb.rhel.id
  name                = "readiness-http"
  number_of_probes    = 1
  port                = 80
  probe_threshold     = 1
  protocol            = "Tcp"
  request_path        = null
}

