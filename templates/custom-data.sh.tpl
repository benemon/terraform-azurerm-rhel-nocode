#!/bin/bash

# register with rhsm
rhc connect -organization ${var_rhsm_organisation_id} -activation-key ${var_rhsm_activation_key}

# add the hashicorp rpm repositories
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# add the azure rpm repositories and install azure cli
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm