variable "load_balancer_rule_sets" {
  description = <<EOT
Map of load_balancer_rule_sets, attributes below
Required:
    - load_balancer_id
    - name
    - items (block):
        - action (required)
        - allowed_methods (optional)
        - are_invalid_characters_allowed (optional)
        - conditions (optional, block):
            - attribute_name (required)
            - attribute_value (required)
            - operator (optional)
        - default_max_connections (optional)
        - description (optional)
        - header (optional)
        - http_large_header_size_in_kb (optional)
        - ip_max_connections (optional, block):
            - ip_addresses (optional)
            - max_connections (optional)
        - prefix (optional)
        - redirect_uri (optional, block):
            - host (optional)
            - path (optional)
            - port (optional)
            - protocol (optional)
            - query (optional)
        - response_code (optional)
        - status_code (optional)
        - suffix (optional)
        - value (optional)
Optional:
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    load_balancer_id = string
    name             = string
    items = list(object({
      action                         = string
      allowed_methods                = optional(set(string))
      are_invalid_characters_allowed = optional(bool)
      conditions = optional(list(object({
        attribute_name  = string
        attribute_value = string
        operator        = optional(string)
      })))
      default_max_connections      = optional(number)
      description                  = optional(string)
      header                       = optional(string)
      http_large_header_size_in_kb = optional(number)
      ip_max_connections = optional(list(object({
        ip_addresses    = optional(list(string))
        max_connections = optional(number)
      })))
      prefix = optional(string)
      redirect_uri = optional(object({
        host     = optional(string)
        path     = optional(string)
        port     = optional(number)
        protocol = optional(string)
        query    = optional(string)
      }))
      response_code = optional(number)
      status_code   = optional(number)
      suffix        = optional(string)
      value         = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.load_balancer_rule_sets : (
        length(v.items) >= 1
      )
    ])
    error_message = "Each items list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.load_balancer_rule_sets : (
        alltrue([for item in v.items : (contains([for v in ["ADD_HTTP_REQUEST_HEADER", "ADD_HTTP_RESPONSE_HEADER", "ALLOW", "CONTROL_ACCESS_USING_HTTP_METHODS", "EXTEND_HTTP_REQUEST_HEADER_VALUE", "EXTEND_HTTP_RESPONSE_HEADER_VALUE", "HTTP_HEADER", "IP_BASED_MAX_CONNECTIONS", "REDIRECT", "REMOVE_HTTP_REQUEST_HEADER", "REMOVE_HTTP_RESPONSE_HEADER"] : lower(v)], lower(item.action)))])
      )
    ])
    error_message = "must be one of: \"ADD_HTTP_REQUEST_HEADER\", \"ADD_HTTP_RESPONSE_HEADER\", \"ALLOW\", \"CONTROL_ACCESS_USING_HTTP_METHODS\", \"EXTEND_HTTP_REQUEST_HEADER_VALUE\", \"EXTEND_HTTP_RESPONSE_HEADER_VALUE\", \"HTTP_HEADER\", \"IP_BASED_MAX_CONNECTIONS\", \"REDIRECT\", \"REMOVE_HTTP_REQUEST_HEADER\", \"REMOVE_HTTP_RESPONSE_HEADER\""
  }
  validation {
    condition = alltrue([
      for k, v in var.load_balancer_rule_sets : (
        alltrue([for item in v.items : (item.conditions == null || alltrue([for item in item.conditions : (contains([for v in ["PATH", "SOURCE_IP_ADDRESS", "SOURCE_VCN_ID", "SOURCE_VCN_IP_ADDRESS"] : lower(v)], lower(item.attribute_name)))]))])
      )
    ])
    error_message = "must be one of: \"PATH\", \"SOURCE_IP_ADDRESS\", \"SOURCE_VCN_ID\", \"SOURCE_VCN_IP_ADDRESS\""
  }
}

