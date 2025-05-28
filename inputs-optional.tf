variable "existing_resource_group_name" {
  description = "Name of existing resource group to deploy resources into"
  type        = string
  default     = null
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "name" {
  description = "The default name will be product+component+env, you can override the product+component part by setting this"
  type        = string
  default     = null
}



variable "user_assigned_identity_ids" {
  description = "List of object IDs of user assigned managed identities to assign to MSSQL server."
  type        = list(string)
  default     = []
}

variable "enable_system_assigned_identity" {
  description = "Whether to enable system assigned managed identity for MSSQL server."
  type        = bool
  default     = true
}


variable "enable_http2" {
  description = "Enable HTTP2? defaults to false"
  default     = true
  type        = bool
}

variable "sku_name" {
  description = "name of the SKU to use for Application Gateway"
  default     = "Basic"
}

variable "sku_tier" {
  description = "tier of the SKU to use for Application Gateway"
  default     = "Basic"
}

variable "min_capacity" {
  default = null
}

variable "max_capacity" {
  default = null
}

variable "app_gw_rewrite_rules" {
  description = "List of rewrite rules"
  type = list(object({
    ruleset_name  = string
    name          = string
    rule_sequence = number
    condition = object({
      variable    = string
      pattern     = string
      ignore_case = bool
      negate      = bool
    })
    response_header_configuration = object({
      header_name  = string
      header_value = string
    })
    url = object({
      components = string
      path       = string
      reroute    = bool
    })
  }))
  default = []
}

variable "enable_waf" {
  default = true
}

variable "waf_mode" {
  description = "Mode for waf to run in"
  default     = "Detection"
}

variable "waf_managed_rules" {
  type = list(object({
    type    = string
    version = string
    rule_group_override = list(object({
      rule_group_name = string
      rule = list(object({
        id      = string
        enabled = bool
        action  = string
      }))
    }))
  }))
  default = null
}

variable "waf_custom_rules" {
  type = list(object({
    name      = string
    priority  = number
    rule_type = string
    match_conditions = list(object({
      match_variables = list(object({
        variable_name = string
        selector      = optional(string)
      }))
      operator           = string
      negation_condition = bool
      match_values       = list(string)
    }))
    action = string
  }))
  default = null
}

variable "tags" {
  description = "Tags to be applied to the resource"
  type        = map(string)
  default     = {}

}
