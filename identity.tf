resource "azurerm_user_assigned_identity" "rhel" {
  location            = data.azurerm_resource_group.compute_rg.location
  name                = "${local.vm_name}-identity"
  resource_group_name = data.azurerm_resource_group.compute_rg.name
}