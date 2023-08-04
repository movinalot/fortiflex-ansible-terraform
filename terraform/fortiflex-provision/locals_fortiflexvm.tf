locals {

  # fortiflex_programs
  program_serial_number = var.program_serial_number

  # fortiflexvm_config

  configs = {
    VM04-ATP-02 = {
      product_type          = "FGT_VM_Bundle"
      program_serial_number = local.program_serial_number
      name                  = "VM04-ATP-02"
      status                = "ACTIVE"
      product_config = [
        {
          cpu_size    = "4"
          service_pkg = "ATP"
          vdom_num    = "0"
        }
      ]
    }
    VM04-LCS-02 = {
      product_type          = "FGT_VM_LCS"
      program_serial_number = local.program_serial_number
      name                  = "VM04-LCS-02"
      status                = "ACTIVE"
      product_config = [
        {
          cloud_services      = ["FAMS", "SWNM", "AFAC", "FAZC"]
          cpu_size            = "4"
          fortiguard_services = ["IPS", "AVDB", "FGSA", "DLDB", "FAIS", "FURLDNS"]
          support_service     = "ASET"
          vdom_num            = "1"
        }
      ]
    }
  }

  # fortiflexvm_entitlements_vm
  entitlements_vms = {
    entitlements_vm_1 = {
      config_id   = fortiflexvm_config.config["VM04-ATP-02"].id
      description = "VM04-ATP-02 VM 1"
      folder_path = "My Assets/VM04-ATP-02"
    }
  }
}
