data "fortiflexvm_vms_list" "vms_list" {

  for_each = local.configs_map

  config_id = each.value.id
}

output "vms_list" {
  value = data.fortiflexvm_vms_list.vms_list
}