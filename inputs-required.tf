variable "env" {
  description = "Environment value"
  type        = string
}

variable "common_tags" {
  description = "Common tag to be applied to resources"
  type        = map(string)
}

variable "product" {
  description = "https://hmcts.github.io/glossary/#product"
  type        = string
}

variable "component" {
  description = "https://hmcts.github.io/glossary/#component"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to deploy the Application Gateway into"
  type        = string

}

variable "backend_address_pools" {
  description = "list of backend pool"
  type = list(object({
    name                      = string
    backend_pool_ip_addresses = optional(list(string), [])
    backend_pool_fqdns        = optional(list(string), [])
  }))
}


variable "probes" {
  description = "List of probes"
  type = list(object({
    name                                      = string
    interval                                  = number
    path                                      = string
    timeout                                   = number
    unhealthy_threshold                       = number
    pick_host_name_from_backend_http_settings = bool
  }))
}


variable "backend_http_settings" {
  description = "List of backend pool settings"
  type = list(object({
    name                                = string
    probe_name                          = string
    cookie_based_affinity               = string
    affinity_cookie_name                = string
    request_timeout                     = number
    port                                = number
    pick_host_name_from_backend_address = bool
    connection_draining = list(object({
      enabled           = optional(bool, false)
      drain_timeout_sec = optional(number, 15)
    }))
  }))
}

variable "http_listeners" {
  description = "List of http listener"
  type = list(object({
    name                 = string
    ssl_enabled          = bool
    ssl_certificate_name = string
  }))
}

variable "request_routing_rules" {
  description = "List of routing rules"
  type = list(object({
    name                       = string
    priority                   = number
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
  }))
}

variable "url_path_map" {
  description = "List of url_path_map"
  type = list(object({
    default_backend_address_pool_name  = string
    default_backend_http_settings_name = string
    path_rule = list(object({
      name                       = string
      paths                      = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
    }))
  }))
}

variable "ssl_cert_name" {
  description = "Name of the SSL certificate in Key Vault"
  type        = string

}

variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string

}

variable "keyvault_rg" {
  description = "Name of the resource group where the Key Vault is located"
  type        = string
}
