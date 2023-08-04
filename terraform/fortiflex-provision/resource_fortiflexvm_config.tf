resource "fortiflexvm_config" "config" {
  for_each = local.configs

  product_type          = each.value.product_type # "FGT_VM_Bundle", "FGT_VM_LCS", "FWB_VM", "FMG_VM", "FAZ_VM", "FPC_VM"
  program_serial_number = each.value.program_serial_number
  name                  = each.value.name
  status                = each.value.status # "ACTIVE", "DISABLED"

  dynamic "fgt_vm_bundle" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_Bundle"
    ]
    content {
      cpu_size    = fgt_vm_bundle.value.cpu_size    # "1", "2", "4", "8", "16", "32", "2147483647"
      service_pkg = fgt_vm_bundle.value.service_pkg # "FC", "UTM", "ENT", "ATP"
      vdom_num    = fgt_vm_bundle.value.vdom_num    # 0 ~ 500
    }
  }

  dynamic "fgt_vm_lcs" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_LCS"
    ]
    content {
      cpu_size            = fgt_vm_lcs.value.cpu_size            # 1 ~ 96
      cloud_services      = fgt_vm_lcs.value.cloud_services      # "FAMS", "SWNM", "AFAC", "FAZC"
      support_service     = fgt_vm_lcs.value.support_service     # "FC247", "ASET"
      fortiguard_services = fgt_vm_lcs.value.fortiguard_services # "IPS", "AVDB", "FGSA", "DLDB", "FAIS", "FURLDNS"
      vdom_num            = fgt_vm_lcs.value.vdom_num            # 1 ~ 500
    }
  }

  dynamic "fwb_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWB_VM"
    ]
    content {
      cpu_size    = fwb_vm.value.cpu_size    # "1", "2", "4", "8", "16"
      service_pkg = fwb_vm.value.service_pkg # "FWBSTD", "FWBADV"
    }
  }

  dynamic "fmg_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FMG_VM"
    ]
    content {
      managed_dev = fmg_vm.value.managed_dev # 1 ~ 100000
      adom_num    = fmg_vm.value.adom_num    # 1 ~ 100000
    }
  }

  dynamic "faz_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAZ_VM"
    ]
    content {
      daily_storage   = faz_vm.value.daily_storage   # 5 ~ 8300
      support_service = faz_vm.value.support_service # "FAZFC247"
      adom_num        = faz_vm.value.adom_num        # 0 ~ 1200
    }
  }

  dynamic "fpc_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FPC_VM"
    ]
    content {
      managed_dev = fpc_vm.value.managed_dev # 0 ~ 100000
    }
  }

  dynamic "fad_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAD_VM"
    ]
    content {
      cpu_size    = fad_vm.value.cpu_size    # "1", "2", "4", "8", "16", "32"
      service_pkg = fad_vm.value.service_pkg # "FDVSTD", "FDVADV", "FDVFC247"
    }
  }

  dynamic "fgt_hw" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_HW"
    ]
    content {
      device_model = fgt_hw.value.device_model # "FGT40F", "FGT60F", "FGT70F", "FGT80F", "FG100F", "FGT60E", "FGT61F", "FG100E", "FG101F", "FG200E", "FG200F", "FG201F", "FG4H0F", "FG6H0F"
      service_pkg  = fgt_hw.value.service_pkg  # "FGHWFC247", "FGHWFCEL", "FGHWATP", "FGHWUTP", "FGHWENT"
      addons       = fgt_hw.value.addons       # only support "NONE" now. Will support "FGHWFCELU" in the future.
    }
  }
}

output "config" {
  value = fortiflexvm_config.config
}