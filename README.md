# terraform-azurerm-rhel-nocode
An example no-code module for creating a sequence of RHEL Virtual Machine Instances in Azure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.77.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool.ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool_address.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_backend_address_pool_address.ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_nat_rule.ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_outbound_rule.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_outbound_rule) | resource |
| [azurerm_lb_probe.readiness-http](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_probe.readiness-https](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.http](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_lb_rule.https](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.http](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.https](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_user_assigned_identity.rhel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_pet.compute_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [azurerm_resource_group.compute_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.compute_sn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.compute_vn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra Azure Resource Tags | `map(any)` | `{}` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Target Resource Group Name | `string` | n/a | yes |
| <a name="input_rhsm_activation_key"></a> [rhsm\_activation\_key](#input\_rhsm\_activation\_key) | RHSM Activation Key | `string` | n/a | yes |
| <a name="input_rhsm_organisation_id"></a> [rhsm\_organisation\_id](#input\_rhsm\_organisation\_id) | RHSM Organisation ID | `string` | n/a | yes |
| <a name="input_ssh_admin_user"></a> [ssh\_admin\_user](#input\_ssh\_admin\_user) | Admin User SSH Username | `string` | `"rheluser"` | no |
| <a name="input_ssh_admin_user_public_key"></a> [ssh\_admin\_user\_public\_key](#input\_ssh\_admin\_user\_public\_key) | Admin User SSH Public Key configured on the host at deploy time | `string` | n/a | yes |
| <a name="input_vm_instance_count"></a> [vm\_instance\_count](#input\_vm\_instance\_count) | How many instances should be created | `number` | n/a | yes |
| <a name="input_vm_name_prefix"></a> [vm\_name\_prefix](#input\_vm\_name\_prefix) | Each VM is created with a randomly generated name. Assign a common prefix. | `string` | n/a | yes |
| <a name="input_vm_owner"></a> [vm\_owner](#input\_vm\_owner) | Individual or Team responsible | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Azure Virtual Machine Size | `string` | `"Standard_D2as_v4"` | no |
| <a name="input_vm_sku"></a> [vm\_sku](#input\_vm\_sku) | Azure RHEL Virtual Machine SKU | `string` | `"rhel-lvm91-gen2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rhel_default_username"></a> [rhel\_default\_username](#output\_rhel\_default\_username) | The Default Admin Username of the Azure Virtual Machine Instance |
| <a name="output_rhel_lb_public_ip"></a> [rhel\_lb\_public\_ip](#output\_rhel\_lb\_public\_ip) | The Public IP Adress of the LB in front of the Azure Virtual Machine Instance(s) |
| <a name="output_rhel_private_ip"></a> [rhel\_private\_ip](#output\_rhel\_private\_ip) | The Private IP Adress of the Azure Virtual Machine Instance |
| <a name="output_rhel_vm_id"></a> [rhel\_vm\_id](#output\_rhel\_vm\_id) | The ID of the Azure Virtual Machine Instance |
