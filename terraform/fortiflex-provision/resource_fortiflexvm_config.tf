resource "fortiflexvm_config" "config" {
  product_type          = local.product_type
  program_serial_number = local.program_serial_number
  name                  = local.config_name
  fgt_vm_bundle {
    cpu_size    = local.cpu_size
    service_pkg = local.service_pkg
  }
}

output "config" {
  value = fortiflexvm_config.config
}