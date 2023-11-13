variable "vm_name_prefix" {
  description = "Each VM is created with a randomly generated name. Assign a common prefix."
  type        = string
}

variable "vm_owner" {
  description = "Individual or Team responsible"
  type        = string
}

variable "vm_size" {
  description = "Azure Virtual Machine Size"
  default     = "Standard_D2as_v4"
  type        = string
}

variable "vm_instance_count" {
  description = "How many instances should be created"
  type        = number
}

variable "vm_sku" {
  description = "Azure RHEL Virtual Machine SKU"
  default     = "rhel-lvm91-gen2"
  type        = string
}

variable "extra_tags" {
  description = "Extra Azure Resource Tags"
  type        = map(any)
  default     = {}
}

variable "rg_name" {
  description = "Target Resource Group Name"
  type        = string
}

variable "ssh_admin_user" {
  description = "Admin User SSH Username"
  type        = string
  default     = "rheluser"
}

variable "ssh_admin_user_public_key" {
  description = "Admin User SSH Public Key configured on the host at deploy time"
  type        = string
}

variable "rhsm_activation_key" {
  description = "RHSM Activation Key"
  type        = string
}

variable "rhsm_organisation_id" {
  description = "RHSM Organisation ID"
  type        = string
}