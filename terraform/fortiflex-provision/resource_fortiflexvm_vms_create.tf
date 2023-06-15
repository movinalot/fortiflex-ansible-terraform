resource "fortiflexvm_vms_create" "vms_create" {
  config_id   = fortiflexvm_config.config.id
  description = local.config_name
  folder_path = local.folder_path
  vm_count    = local.vm_count
}

output "vms_create" {
  value = fortiflexvm_vms_create.vms_create
}