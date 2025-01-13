resource "fortiflexvm_config" "config" {
  for_each = local.configs

  product_type          = each.value.product_type # FAD_VM, FAP_HW, FAZ_VM, FC_EMS_CLOUD, FC_EMS_OP, FGT_HW, FGT_VM_Bundle, FGT_VM_LCS, FMG_VM, FPC_VM, FSH_HW, FWB_VM, FWBC_PRIVATE, FWBC_PUBLIC, FORTISASE, FORTIEDR, FORTIRECON, SIEM_CLOUD
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
      service_pkg = fad_vm.value.service_pkg #  "FDVFC247" (FortiCare Premium), "FDVNET" (Network Security), "FDVAPP" (Application Security), "FDVAI" (AI Security)
    }
  }

  dynamic "fap_hw" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAP_HW"
    ]
    content {
      device_model = fap_hw.value.device_model # "FP23JF": FortiAP-23JF, "FP221E": FortiAP-221E, "FP223E": FortiAP-223E, "FP231F": FortiAP-231F, "FP231G": FortiAP-231G, "FP233G": FortiAP-233G, "FP234F": FortiAP-234F, "FP234G": FortiAP-234G, "FP431F": FortiAP-431F, "FP431G": FortiAP-431G, "FP432F": FortiAP-432F, "F432FR": FortiAP-432FR, "FP432G": FortiAP-432G, "FP433F": FortiAP-433F, "FP433G": FortiAP-433G, "FP441K": FortiAP-441K, "FP443K": FortiAP-443K, "FP831F": FortiAP-831F, "PU231F": FortiAP-U231F, "PU234F": FortiAP-U234F, "PU422E": FortiAP-U422EV, "PU431F": FortiAP-U431F, "PU432F": FortiAP-U432F, "PU433F": FortiAP-U433F
      service_pkg  = fap_hw.value.service_pkg  # "FAPHWFC247" (FortiCare Premium), "FAPHWFCEL" (FortiCare Elite)
      addons       = fap_hw.value.addons       # "FAPHWFSFG": FortiSASE Cloud Managed AP
    }
  }

  dynamic "faz_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FAZ_VM"
    ]
    content {
      adom_num        = faz_vm.value.adom_num        # 0 ~ 1200
      daily_storage   = faz_vm.value.daily_storage   # 5 ~ 8300 (GB) 
      support_service = faz_vm.value.support_service # FAZFC247
      addons          = faz_vm.value.addons          # "FAZISSS" (OT Security Service), "FAZFGSA" (Attack Surface Security Service)
    }
  }

  dynamic "fc_ems_cloud" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FC_EMS_CLOUD"
    ]
    content {
      ztna_num         = fc_ems_cloud.value.ztna_num         # 0 or 25 ~ 250000
      ztna_fgf_num     = fc_ems_cloud.value.ztna_fgf_num     # 0 or 25 ~ 250000
      epp_ztna_num     = fc_ems_cloud.value.epp_ztna_num     # 0 or 25 ~ 250000
      epp_ztna_fgf_num = fc_ems_cloud.value.epp_ztna_fgf_num # 0 or 25 ~ 250000
      chromebook       = fc_ems_cloud.value.chromebook       # 0 or 25 ~ 250000
      addons           = fc_ems_cloud.value.addons           # "BPS" (FortiCare Best Practice)
    }
  }

  dynamic "fc_ems_op" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FC_EMS_OP"
    ]
    content {
      ztna_num        = fc_ems_op.value.ztna_num        # 0 or 25 ~ 250000
      epp_ztna_num    = fc_ems_op.value.epp_ztna_num    # 0 or 25 ~ 250000
      chromebook      = fc_ems_op.value.chromebook      # 0 or 25 ~ 250000
      support_service = fc_ems_op.value.support_service # "FCTFC247" (FortiCare Premium)
      addons          = fc_ems_op.value.addons          # "BPS" (FortiCare Best Practice)
    }
  }

  dynamic "fgt_hw" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_HW"
    ]
    content {
      device_model = fgt_hw.value.device_model # "FGT40F": FortiGate 40F, "FWF40F": FortiWifi 40F, "FGT60E": FortiGate 60E, "FGT60F": FortiGate 60F, "FWF60F": FortiWifi 60F, "FGR60F": FortiGateRugged 60F, "FGT61F": FortiGate 61F, "FGT70F": FortiGate 70F, "FR70FB": FortiGateRugged 70F, "FGT80F": FortiGate 80F, "FGT81F": FortiGate 81F, "FG100E": FortiGate 100E, "FG100F": FortiGate 100F, "FG101E": FortiGate 101E, "FG101F": FortiGate 101F, "FG200E": FortiGate 200E, "FG200F": FortiGate 200F, "FG201F": FortiGate 201F, "FG4H0F": FortiGate 400F, "FG4H1F": FortiGate 401F, "FG6H0F": FortiGate 600F, "FG1K0F": FortiGate 1000F, "FG180F": FortiGate 1800F, "F2K60F": FortiGate 2600F, "FG3K0F": FortiGate 3000F, "FG3K1F": FortiGate 3001F, "FG3K2F": FortiGate 3200F, "FG40FI": FortiGate 40F-3G4G, "FW40FI": FortiWifi 40F-3G4G, "FWF61F": FortiWifi 61F, "FR60FI": FortiGateRugged 60F 3G4G, "FGT71F": FortiGate 71F, "FG80FP": FortiGate 80F-PoE, "FG80FB": FortiGate 80F-Bypass, "FG80FD": FortiGate 80F DSL, "FWF80F": FortiWiFi 80F-2R, "FW80FS": FortiWiFi 80F-2R-3G4G-DSL, "FWF81F": FortiWiFi 81F 2R, "FW81FS": FortiWiFi 81F-2R-3G4G-DSL, "FW81FD": FortiWiFi 81F-2R-3G4G-PoE, "FW81FP": FortiWiFi 81F 2R POE, "FG81FP": FortiGate 81F-PoE, "FGT90G": FortiGate 90G, "FGT91G": FortiGate 91G, "FG201E": FortiGate 201E, "FG4H0E": FortiGate 400E, "FG4HBE": FortiGate 400E BYPASS, "FG4H1E": FortiGate 401E, "FD4H1E": FortiGate 401E DC, "FG6H0E": FortiGate 600E, "FG6H1E": FortiGate 601E, "FG6H1F": FortiGate 601F, "FG9H0G": FortiGate 900G, "FG9H1G": FortiGate 901G, "FG1K1F": FortiGate 1001F, "FG181F": FortiGate 1801F, "FG3K7F": FortiGate 3700F, "FG39E6": FortiGate 3960E, "FG441F": FortiGate 4401F
      service_pkg  = fgt_hw.value.service_pkg  # "FGHWFC247" (FortiCare Premium), "FGHWFCEL" (FortiCare Elite), "FGHWATP" (ATP), "FGHWUTP" (UTP) or "FGHWENT" (Enterprise)
      addons       = fgt_hw.value.addons       # "FGHWFCELU": FortiCare Elite Upgrade, "FGHWFAMS": FortiGate Cloud Management, "FGHWFAIS": AI-Based In-line Sandbox, "FGHWSWNM": SD-WAN Underlay, "FGHWDLDB": FortiGuard DLP, "FGHWFAZC": FortiAnalyzer Cloud, "FGHWSOCA": SOCaaS, "FGHWMGAS": Managed FortiGate, "FGHWSPAL": SD-WAN Connector for FortiSASE, "FGHWFCSS": FortiConverter Service
    }
  }

  dynamic "fgt_vm_bundle" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_Bundle"
    ]
    content {
      cloud_services      = fgt_vm_bundle.value.cloud_services      # "FGTFAMS": FortiGate Cloud Management, "FGTSWNM": SD-WAN Underlay, "FGTSOCA": SOCaaS, "FGTFAZC": FortiAnalyzer Cloud, "FGTSWOS": Cloud-based Overlay-as-a-Service, "FGTFSPA": SD-WAN Connector for FortiSASE
      cpu_size            = fgt_vm_bundle.value.cpu_size            # 1 ~ 96
      fortiguard_services = fgt_vm_bundle.value.fortiguard_services # "FGTAVDB": Advanced Malware Protection, "FGTFAIS": AI-Based In-line Sandbox, "FGTISSS": FortiGuard OT Security Service, "FGTDLDB": FortiGuard DLP, "FGTFGSA": FortiGuard Attack Surface Security Service, "FGTFCSS": FortiConverter Service
      service_pkg         = fgt_vm_bundle.value.service_pkg         # "FC" (FortiCare), "UTP" (UTP), "ENT" (Enterprise) or "ATP" (ATP)
      support_service     = fgt_vm_bundle.value.support_service     # "FC" (FortiCare), "UTP" (UTP), "ENT" (Enterprise) or "ATP" (ATP)
      vdom_num            = fgt_vm_bundle.value.vdom_num            # 0 ~ 500
    }
  }

  dynamic "fgt_vm_lcs" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FGT_VM_LCS"
    ]
    content {
      cloud_services      = fgt_vm_lcs.value.cloud_services      # "FAMS": FortiGate Cloud, "SWNM": SD-WAN Underlay, "AFAC": FortiAnalyzer Cloud with SOCaaS, "FAZC": FortiAnalyzer Cloud
      cpu_size            = fgt_vm_lcs.value.cpu_size            # 1 ~ 96
      fortiguard_services = fgt_vm_lcs.value.fortiguard_services # "IPS": Intrusion Prevention, "AVDB": Advanced Malware, "FURLDNS": Web, DNS & Video Filtering, "FGSA": Security Rating, "DLDB": DLP, "FAIS": AI-Based InLine Sandbox
      support_service     = fgt_vm_lcs.value.support_service     # "FC247" (FortiCare 24x7) or "ASET" (FortiCare Elite)
      vdom_num            = fgt_vm_lcs.value.vdom_num            # 1 ~ 500
    }
  }

  dynamic "fmg_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FMG_VM"
    ]
    content {
      adom_num    = fmg_vm.value.adom_num    # 1 ~ 100000
      managed_dev = fmg_vm.value.managed_dev # 1 ~ 100000
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

  dynamic "fsw_hw" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FSW_HW"
    ]
    content {
      device_model = fsw_hw.value.device_model # "S108EN": FortiSwitch-108E, "S108EF": FortiSwitch-108E-FPOE, "S108EP": FortiSwitch-108E-POE, "S108FN": FortiSwitch-108F, "S108FF": FortiSwitch-108F-FPOE, "S108FP": FortiSwitch-108F-POE, "S124EN": FortiSwitch-124E, "S124EF": FortiSwitch-124E-FPOE, "S124EP": FortiSwitch-124E-POE, "S124FN": FortiSwitch-124F, "S124FF": FortiSwitch-124F-FPOE, "S124FP": FortiSwitch-124F-POE, "S148EN": FortiSwitch-148E, "S148EP": FortiSwitch-148E-POE, "S148FN": FortiSwitch-148F, "S148FF": FortiSwitch-148F-FPOE, "S148FP": FortiSwitch-148F-POE, "S224DF": FortiSwitch-224D-FPOE, "S224EN": FortiSwitch-224E, "S224EP": FortiSwitch-224E-POE, "S248DN": FortiSwitch-248D, "S248EF": FortiSwitch-248E-FPOE, "S248EP": FortiSwitch-248E-POE, "S424DN": FortiSwitch-424D, "S424DF": FortiSwitch-424D-FPOE, "S424DP": FortiSwitch-424D-POE, "S424EN": FortiSwitch-424E, "S424EF": FortiSwitch-424E-FPOE, "S424EI": FortiSwitch-424E-Fiber, "S424EP": FortiSwitch-424E-POE, "S448DN": FortiSwitch-448D, "S448DP": FortiSwitch-448D-POE, "S448EN": FortiSwitch-448E, "S448EF": FortiSwitch-448E-FPOE, "S448EP": FortiSwitch-448E-POE, "S524DN": FortiSwitch-524D, "S524DF": FortiSwitch-524D-FPOE, "S548DN": FortiSwitch-548D, "S548DF": FortiSwitch-548D-FPOE, "S624FN": FortiSwitch-624F, "S624FF": FortiSwitch-624F-FPOE, "S648FN": FortiSwitch-648F, "S648FF": FortiSwitch-648F-FPOE, "FS1D24": FortiSwitch-1024D, "FS1E24": FortiSwitch-1024E, "FS1D48": FortiSwitch-1048D, "FS1E48": FortiSwitch-1048E, "FS2F48": FortiSwitch-2048F, "FS3D32": FortiSwitch-3032D, "FS3E32": FortiSwitch-3032E, "S426EF": FortiSwitch-M426E-FPOE, "ST1E24": FortiSwitch-T1024E, "SR12DP": FortiSwitchRugged-112D-POE, "SR24DN": FortiSwitchRugged-124D
      service_pkg  = fsw_hw.value.service_pkg  # "FSWHWFC247" (FortiCare Premium), "FSWHWFCEL" (FortiCare Elite)
    }
  }

  dynamic "fwb_vm" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWB_VM"
    ]
    content {
      cpu_size    = fwb_vm.value.cpu_size    # 1, 2, 4, 8, 16
      service_pkg = fwb_vm.value.service_pkg # "FWBSTD" (Standard) or "FWBADV" (Advanced)
    }
  }

  dynamic "fwbc_private" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWBC_PRIVATE"
    ]
    content {
      average_throughput = fwbc_private.value.average_throughput # 10, 25, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000
      web_applications   = fwbc_private.value.web_applications   # 0 ~ 2000
    }
  }

  dynamic "fwbc_public" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FWBC_PUBLIC"
    ]
    content {
      average_throughput = fwbc_public.value.average_throughput # 10, 25, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000
      web_applications   = fwbc_public.value.web_applications   # 0 ~ 2000
    }
  }

  dynamic "fortisase" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FORTISASE"
    ]
    content {
      users                     = fortisase.value.users                     # 50 ~ 50000
      service_pkg               = fortisase.value.service_pkg               # "FSASESTD" (Standard) or "FSASEADV" (Advanced)
      bandwidth                 = fortisase.value.bandwidth                 # 25 ~ 10000
      dedicated_ips             = fortisase.value.dedicated_ips             # 4 ~ 65534
      additional_compute_region = fortisase.value.additional_compute_region # (Optional) The 'Additional Compute Region' can be scaled up in an increment of 1 but scaling down is NOT allowed
    }
  }

  dynamic "fortiedr" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FORTIEDR"
    ]
    content {
      service_pkg = fortiedr.value.service_pkg # "FEDRPDR" (Discover/Protect/Respond)
      endpoints   = fortiedr.value.endpoints   # Number of Endpoints
      addons      = fortiedr.value.addons      # "FEDRXDR" (XDR)
    }
  }

  dynamic "fortirecon" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "FORTITRECON"
    ]
    content {
      service_pkg   = fortirecon.value.service_pkg   # "FRNEASM" (External Attack Surface Monitoring), "FRNEASMBP" (External Attack Surface Monitoring & Brand Protect), "FRNEASMBPACI" (External Attack Surface Monitoring & Brand Protect & Adversary Centric Intelligence)
      asset_num     = fortirecon.value.asset_num     # Number between 200 and 1,000,000 (inclusive). Value should be divisible by 50
      network_num   = fortirecon.value.network_num   # 0 ~ 100
      executive_num = fortirecon.value.executive_num # Number between 0 and 1,000 (inclusive). This value can only be set to 0 if service_pkg is "FRNEASM" or "FRNEASMBP"
      vendor_num    = fortirecon.value.vendor_num    # Number between 0 and 1,000 (inclusive) This value can only be set to 0 if service_pkg is "FRNEASM" or "FRNEASMBP"
    }
  }

  dynamic "siem_cloud" {
    for_each = [
      for entitlement in each.value.product_config : entitlement
      if each.value.product_type == "SIEM_CLOUD"
    ]
    content {
      compute_units             = siem_cloud.value.compute_units             # Number between 10 and 600 (inclusive). Value should be divisible by 10
      additional_online_storage = siem_cloud.value.additional_online_storage # Number between 500 and 60,000 (inclusive). Value should be divisible by 500. The 'Additional Online Storage' can be scaled up in an increment of 500 but scaling down is NOT allowed
      archive_storage           = siem_cloud.value.archive_storage           # Number between 0 and 60,000 (inclusive). Value should be divisible by 500. The 'Archive Storage' can be scaled up in an increment of 500 but scaling down is NOT allowed
    }
  }
}

output "config" {
  value = fortiflexvm_config.config
}