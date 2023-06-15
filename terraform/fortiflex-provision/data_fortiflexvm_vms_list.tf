data "fortiflexvm_vms_list" "vms_list" {
  config_id = fortiflexvm_vms_create.vms_create.config_id
}

output "vms_list" {
  value = data.fortiflexvm_vms_list.vms_list
}