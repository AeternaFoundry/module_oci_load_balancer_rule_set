resource "oci_load_balancer_rule_set" "load_balancer_rule_sets" {
  for_each = var.load_balancer_rule_sets

  load_balancer_id = each.value.load_balancer_id
  name             = each.value.name

  dynamic "items" {
    for_each = each.value.items
    content {
      action                         = items.value.action
      allowed_methods                = items.value.allowed_methods
      are_invalid_characters_allowed = items.value.are_invalid_characters_allowed
      dynamic "conditions" {
        for_each = items.value.conditions != null ? items.value.conditions : []
        content {
          attribute_name  = conditions.value.attribute_name
          attribute_value = conditions.value.attribute_value
          operator        = conditions.value.operator
        }
      }
      default_max_connections      = items.value.default_max_connections
      description                  = items.value.description
      header                       = items.value.header
      http_large_header_size_in_kb = items.value.http_large_header_size_in_kb
      dynamic "ip_max_connections" {
        for_each = items.value.ip_max_connections != null ? items.value.ip_max_connections : []
        content {
          ip_addresses    = ip_max_connections.value.ip_addresses
          max_connections = ip_max_connections.value.max_connections
        }
      }
      prefix = items.value.prefix
      dynamic "redirect_uri" {
        for_each = items.value.redirect_uri != null ? [items.value.redirect_uri] : []
        content {
          host     = redirect_uri.value.host
          path     = redirect_uri.value.path
          port     = redirect_uri.value.port
          protocol = redirect_uri.value.protocol
          query    = redirect_uri.value.query
        }
      }
      response_code = items.value.response_code
      status_code   = items.value.status_code
      suffix        = items.value.suffix
      value         = items.value.value
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

