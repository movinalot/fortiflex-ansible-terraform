locals {

  # fortiflex_programs
  program_serial_number = var.program_serial_number

  # fortiflexvm_config
  config_name = "VM04-ATP-01"
  folder_name = "VM04-ATP-01"
  product_type = "FGT_VM_Bundle"
  cpu_size = "4"
  service_pkg = "ATP"

  # fortiflexvm_vms_create
  folder_path = "My Assets/${local.folder_name}"
  vm_count = 1
}
