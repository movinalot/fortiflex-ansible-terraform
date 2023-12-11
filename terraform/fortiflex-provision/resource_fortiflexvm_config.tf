resource "fortiflexvm_config" "config" {
  for_each = local.configs

  product_type          = each.value.product_type # FAD_VM, FAZ_VM, FC_EMS_CLOUD, FC_EMS_OP, FGT_HW, FGT_VM_Bundle FGT_VM_LCS FMG_VM FPC_VM FWB_VM FWBC_PRIVATE FWBC_PUBLIC
  program_serial_number = each.value.program_serial_number
  name                  = each.value.name
  status                = each.value.status # ACTIVE, DISABLED

  dynamic "fad_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAD_VM"
    ]
    content {
      cpu_size    = fad_vm.value.cpu_size    # 1, 2, 4, 8, 16, 32
      service_pkg = fad_vm.value.service_pkg # FDVSTD, FDVADV, FDVFC247
    }
  }

  dynamic "faz_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAZ_VM"
    ]
    content {
      daily_storage   = faz_vm.value.daily_storage   # 5 ~ 8300
      support_service = faz_vm.value.support_service # FAZFC247
      adom_num        = faz_vm.value.adom_num        # 0 ~ 1200
    }
  }

  dynamic "fc_ems_cloud" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FC_EMS_CLOUD"
    ]
    content {
      ztna_num         = fc_ems_cloud.value.ztna_num         # 0 ~ 250000
      ztna_fgf_num     = fc_ems_cloud.value.ztna_fgf_num     # 0 ~ 250000
      epp_ztna_num     = fc_ems_cloud.value.epp_ztna_num     # 0 ~ 250000
      epp_ztna_fgf_num = fc_ems_cloud.value.epp_ztna_fgf_num # 0 ~ 250000
      chromebook       = fc_ems_cloud.value.chromebook       # 0 ~ 250000
      addons           = fc_ems_cloud.value.addons           # BPS
    }
  }

  dynamic "fc_ems_op" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FC_EMS_OP"
    ]
    content {
      ztna_num        = fc_ems_op.value.ztna_num        # 0 ~ 250000
      epp_ztna_num    = fc_ems_op.value.epp_ztna_num    # 0 ~ 250000
      chromebook      = fc_ems_op.value.chromebook      # 0 ~ 250000
      support_service = fc_ems_op.value.support_service # FCTFC247
      addons          = fc_ems_op.value.addons          # BPS
    }
  }

  dynamic "fgt_hw" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_HW"
    ]
    content {
      device_model = fgt_hw.value.device_model # FGT40F, FWF40F, FGT60E, FGT60F, FWF60F, FGR60F, FGT61F, FGT70F, FR70FB, FGT80F, FGT81F, FG100E, FG100F, FG101E, FG101F, FG200E, FG200F, FG201F, FG4H0F, FG4H1F, FG6H0F, FG1K0F, FG180F, F2K60F, FG3K0F, FG3K1F, FG3K2F, FG40FI, FW40FI, FWF61F, FR60FI, FGT71F, FG80FP, FG80FB, FG80FD, FWF80F, FW80FS, FWF81F, FW81FS, FW81FD, FW81FP, FG81FP, FGT90G, FGT91G, FG201E, FG4H0E, FG4HBE, FG4H1E, FD4H1E, FG6H0E, FG6H1E, FG6H1F, FG9H0G, FG9H1G, FG1K1F, FG181F, FG3K7F, FG39E6, FG441F
      service_pkg  = fgt_hw.value.service_pkg  # FGHWFC247, FGHWFCEL, FGHWATP, FGHWUTP, FGHWENT
      addons       = fgt_hw.value.addons       # FGHWFCELU, FGHWFAMS, FGHWFAIS, FGHWSWNM, FGHWDLDB, FGHWFAZC, FGHWSOCA, FGHWMGAS, FGHWSPAL, FGHWFCSS
    }
  }

  dynamic "fgt_vm_bundle" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_Bundle"
    ]
    content {
      cpu_size            = fgt_vm_bundle.value.cpu_size            # 1 ~ 96
      service_pkg         = fgt_vm_bundle.value.service_pkg         # FC, UTP, ENT, ATP
      vdom_num            = fgt_vm_bundle.value.vdom_num            # 0 ~ 500
      cloud_services      = fgt_vm_bundle.value.cloud_services      # FGTFAMS, FGTSWNM, FGTSOCA, FGTFAZC, FGTSWOS, FGTFSPA
      fortiguard_services = fgt_vm_bundle.value.fortiguard_services # FGTAVDB, FGTFAIS, FGTISSS, FGTFCSS
      support_service     = fgt_vm_bundle.value.support_service     # FGTFCELU
    }
  }

  dynamic "fgt_vm_lcs" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_LCS"
    ]
    content {
      cpu_size            = fgt_vm_lcs.value.cpu_size            # 1 ~ 96
      cloud_services      = fgt_vm_lcs.value.cloud_services      # FAMS, SWNM, AFAC, FAZC
      support_service     = fgt_vm_lcs.value.support_service     # FC247, ASET
      fortiguard_services = fgt_vm_lcs.value.fortiguard_services # IPS, AVDB, FURLDNS, FGSA, DLDB, FAIS
      vdom_num            = fgt_vm_lcs.value.vdom_num            # 1 ~ 500
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

  dynamic "fpc_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FPC_VM"
    ]
    content {
      managed_dev = fpc_vm.value.managed_dev # 1 ~ 100000
    }
  }

  dynamic "fwb_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWB_VM"
    ]
    content {
      cpu_size    = fwb_vm.value.cpu_size    # 1, 2, 4, 8, 16
      service_pkg = fwb_vm.value.service_pkg # FWBSTD, FWBADV
    }
  }

  dynamic "fwbc_private" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWBC_PRIVATE"
    ]
    content {
      average_throughput = fwbc_private.value.avaverage_throughput # 10, 25, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000
      web_applications   = fwbc_private.value.web_applications     # 0 ~ 2000
    }
  }

  dynamic "fwbc_public" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWBC_PUBLIC"
    ]
    content {
      average_throughput = fwbc_public.value.avaverage_throughput # 10, 25, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000
      web_applications   = fwbc_public.value.web_applications     # 0 ~ 2000
    }
  }
}

output "config" {
  value = fortiflexvm_config.config
}