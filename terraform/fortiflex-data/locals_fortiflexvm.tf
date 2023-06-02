locals {
  # Create a map of Programs
  programs_map = {
    for item in data.fortiflexvm_programs_list.programs_list.programs :
    format("%s", item["serial_number"]) => {
      serial_number = item["serial_number"],
    }
  }

  # Create a map of Configurations
  configs_map = {
    for item in local.configs_map_list :
    format("%s_%s", item["program"], item["id"]) => {
      id = item["id"],
    }
  }

  configs_map_list = flatten([
    for program_map, config_list in data.fortiflexvm_configs_list.configs_list : [
      for config in config_list.configs : {
        id      = config.id
        program = program_map
      }
    ]
  ])
}

output "debug_programs_map" {
  value = var.enable_debug_output ? local.programs_map : null
}

output "debug_configs_map" {
  value = var.enable_debug_output ? local.configs_map : null
}

output "debug_configs_map_list" {
  value = var.enable_debug_output ? local.configs_map_list : null
}