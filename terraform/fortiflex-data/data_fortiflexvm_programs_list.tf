data "fortiflexvm_programs_list" "programs_list" {}

output "programs_list" {
  value = data.fortiflexvm_programs_list.programs_list
}