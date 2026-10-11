output "load_balancer_rule_sets_id" {
  description = "Map of id values across all load_balancer_rule_sets, keyed the same as var.load_balancer_rule_sets except keys with no id are omitted"
  value       = { for k, v in oci_load_balancer_rule_set.load_balancer_rule_sets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "load_balancer_rule_sets_items" {
  description = "Map of items values across all load_balancer_rule_sets, keyed the same as var.load_balancer_rule_sets except keys with no items are omitted"
  value       = { for k, v in oci_load_balancer_rule_set.load_balancer_rule_sets : k => v.items if v.items != null && length(v.items) > 0 }
}
output "load_balancer_rule_sets_load_balancer_id" {
  description = "Map of load_balancer_id values across all load_balancer_rule_sets, keyed the same as var.load_balancer_rule_sets except keys with no load_balancer_id are omitted"
  value       = { for k, v in oci_load_balancer_rule_set.load_balancer_rule_sets : k => v.load_balancer_id if v.load_balancer_id != null && length(v.load_balancer_id) > 0 }
}
output "load_balancer_rule_sets_name" {
  description = "Map of name values across all load_balancer_rule_sets, keyed the same as var.load_balancer_rule_sets except keys with no name are omitted"
  value       = { for k, v in oci_load_balancer_rule_set.load_balancer_rule_sets : k => v.name if v.name != null && length(v.name) > 0 }
}
output "load_balancer_rule_sets_state" {
  description = "Map of state values across all load_balancer_rule_sets, keyed the same as var.load_balancer_rule_sets except keys with no state are omitted"
  value       = { for k, v in oci_load_balancer_rule_set.load_balancer_rule_sets : k => v.state if v.state != null && length(v.state) > 0 }
}

