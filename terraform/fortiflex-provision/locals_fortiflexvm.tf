locals {

  # fortiflex_programs
  program_serial_number = var.program_serial_number

  # fortiflexvm_config

  configs = {
    FGT_VM_Bundle_VM04-ATP-02 = {
      product_type          = "FGT_VM_Bundle"
      program_serial_number = local.program_serial_number
      name                  = "FGT_VM_Bundle_VM04-ATP-02"
      status                = "ACTIVE"
      product_config = [
        {
          cpu_size    = "4"
          service_pkg = "ATP"
          vdom_num    = "0"
        }
      ]
    }
    FGT_VM_LCS_VM04-IPS-02 = {
      product_type          = "FGT_VM_LCS"
      program_serial_number = local.program_serial_number
      name                  = "FGT_VM_LCS_VM04-IPS-02"
      status                = "ACTIVE"
      product_config = [
        {
          cloud_services      = ["FAZC"]
          cpu_size            = "4"
          fortiguard_services = ["IPS"]
          support_service     = "ASET"
          vdom_num            = "1"
        }
      ]
    }
    FWB_VM_VM04-FWSTD-02 = {
      product_type          = "FWB_VM"
      program_serial_number = local.program_serial_number
      name                  = "FWB_VM_VM04-FWSTD-02"
      status                = "ACTIVE"
      product_config = [
        {
          cpu_size    = "4"
          service_pkg = "FWBSTD"
        }
      ]
    }
  }

  # fortiflexvm_entitlements_vm
  # end_date = "2023-11-12T00:00:00" # Optional, defaults to program end date.
  # folder_path = "My Assets"        # Optional. defaults to "My Assets"
  # status = "ACTIVE"                # Optional. "ACTIVE" or "STOPPED". Not recommended to set it manually.

  entitlements_vms = {
    entitlements_vm_1 = {
      config_id   = fortiflexvm_config.config["FGT_VM_Bundle_VM04-ATP-02"].id
      description = "FGT_VM_Bundle_VM04-ATP-02 VM 1"
      folder_path = "My Assets/FGT_VM_Bundle_VM04-ATP-02"
    }
    entitlements_vm_2 = {
      config_id   = fortiflexvm_config.config["FGT_VM_Bundle_VM04-ATP-02"].id
      description = "FGT_VM_Bundle_VM04-ATP-02 VM 2"
      folder_path = "My Assets/FGT_VM_Bundle_VM04-ATP-02"
    }
  }
}
