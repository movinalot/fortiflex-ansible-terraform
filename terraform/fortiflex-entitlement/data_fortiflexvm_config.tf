data "fortiflexvm_configs_list" "configs_list" {
  program_serial_number = local.program_serial_number
}

output "configs_list" {
  value = data.fortiflexvm_configs_list.configs_list
}