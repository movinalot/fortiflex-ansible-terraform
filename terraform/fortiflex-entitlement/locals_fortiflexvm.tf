locals {
  # fortiflex_programs
  program_serial_number = var.program_serial_number

  # fortiflexvm_config
  fortiflex_config_name = var.fortiflex_config_name

  # fortiflexvm_entitlements_vm
  # end_date = "2023-11-12T00:00:00" # Optional, defaults to program end date.
  # folder_path = "My Assets"        # Optional. defaults to "My Assets"
  # status = "ACTIVE"                # Optional. "ACTIVE" or "STOPPED". Not recommended to set it manually.

  entitlements_vms = {
    entitlements_vm_1 = {
      config_id   = local.fortiflex_configs_map[local.fortiflex_config_name].id
      description = "FGT VM08-ENT VM 1"
      folder_path = "My Assets"
    }
  }

  fortiflex_configs_map = {
    for item in data.fortiflexvm_configs_list.configs_list.configs :
    format("%s", item["name"]) => {
      name            = item["name"],
      id =  item["id"]
    }
  }
}

output "debug_fortiflex_configs_map" {
  value = var.enable_debug_output ? local.fortiflex_configs_map : null
}
