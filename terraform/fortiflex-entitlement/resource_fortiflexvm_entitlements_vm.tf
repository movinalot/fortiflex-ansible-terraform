resource "fortiflexvm_entitlements_vm" "entitlements_vm" {
  for_each = local.entitlements_vms

  config_id   = each.value.config_id
  description = each.value.description
  folder_path = each.value.folder_path

}

output "entitlements_vm" {
  value = fortiflexvm_entitlements_vm.entitlements_vm
}