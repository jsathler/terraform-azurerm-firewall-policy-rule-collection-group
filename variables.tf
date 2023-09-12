variable "name" {
  description = "The name which should be used for this Firewall Policy Rule Collection Group. This parameter is required"
  type        = string
}

variable "firewall_policy_id" {
  description = "The ID of an existing Firewall Policy where new rules will be created. This parameter is required"
  type        = string
}

variable "priority" {
  description = "The priority of the Firewall Policy Rule Collection Group. The range is 100-65000 and should be unique within the firewall policy. This parameter is required"
  type        = number
}

variable "network_rule_collections" {
  description = <<DESCRIPTION
  - action:                   (optional) The action to take for the network rules in this collection. Possible values are Allow and Deny. Defaults to 'Allow'
  - priority:                 (required) The priority of the network rule collection. The range is 100-65000 and should be unique within this collection group
  - rules:                    (optional) One or more network_rule (rules) blocks as defined below
    - protocols:              (optional) Specifies a list of network protocols this rule applies to. Possible values are Any, TCP, UDP, ICMP. Defaults to 'TCP'
    - destination_ports:      (required) Specifies a list of destination ports
    - source_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)
    - source_ip_groups:       (optional) Specifies a list of source IP groups
    - destination_addresses:  (optional) Specifies a list of destination IP addresses (including CIDR, IP range and *) or Service Tags
    - destination_ip_groups:  (optional) Specifies a list of destination IP groups
    - destination_fqdns:      (optional) Specifies a list of destination FQDNs
  DESCRIPTION

  type = map(object({
    action   = optional(string, "Allow")
    priority = number
    rules = optional(map(object({
      protocols             = optional(list(string), ["TCP"])
      destination_ports     = list(string)
      source_addresses      = optional(list(string), null)
      source_ip_groups      = optional(list(string), null)
      destination_addresses = optional(list(string), null)
      destination_ip_groups = optional(list(string), null)
      destination_fqdns     = optional(list(string), null)
    })), null)
  }))

  default = null
}

variable "nat_rule_collection" {
  description = <<DESCRIPTION
  - action:                   (optional) The action to take for the NAT rules in this collection. Currently, the only possible value is Dnat. Defaults to 'Dnat'
  - priority:                 (required) The priority of the nat rule collection. The range is 100-65000 and should be unique within this collection group
  - rules:                    (required) One or more nat_rule (rules) blocks as defined below
    - protocols:              (optional) Specifies a list of network protocols this rule applies to. Possible values are TCP and UDP. Defaults to 'TCP'    
    - source_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)
    - source_ip_groups:       (optional) Specifies a list of source IP groups
    - destination_address:    (required) The destination IP address (including CIDR)
    - destination_port:       (required) Specifies the destination port
    - translated_address:     (optional) Specifies the translated address
    - translated_fqdn:        (optional) Specifies the translated FQDN
    - translated_port:        (Required) Specifies the translated port
  DESCRIPTION

  type = map(object({
    action   = optional(string, "Dnat")
    priority = number
    rules = map(object({
      protocols           = optional(list(string), ["TCP"])
      source_addresses    = optional(list(string), null)
      source_ip_groups    = optional(list(string), null)
      destination_address = string
      destination_port    = number
      translated_address  = optional(string, null)
      translated_fqdn     = optional(string, null)
      translated_port     = number
    }))
  }))

  default = null
}

variable "application_rule_collection" {
  description = <<DESCRIPTION
  - action:                   (optional) The action to take for the application rules in this collection. Possible values are Allow and Deny. Defaults to 'Allow'
  - priority:                 (required) The priority of the application rule collection. The range is 100-65000 and should be unique within this collection group
  - rules:                    (optional) One or more application_rule (rules) blocks as defined below
    - protocols:              (optional) One or more protocols blocks as defined below
      - type:                 (required) Protocol type. Possible values are Http and Https. Defaults to 'Https'
      - port:                 (required) Port number of the protocol. Range is 0-64000. Defaults to '443'
    - description:            (optional) The description which should be used for this rule
    - source_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)
    - source_ip_groups:       (optional) Specifies a list of source IP groups
    - destination_addresses:  (optional) Specifies a list of destination IP addresses (including CIDR, IP range and *)
    - destination_urls:       (optional) Specifies a list of destination URLs for which policy should hold. Needs Premium SKU for Firewall Policy. Conflicts with destination_fqdns
    - destination_fqdns:      (optional) Specifies a list of destination FQDNs. Conflicts with destination_urls
    - destination_fqdn_tags:  (optional) Specifies a list of destination FQDN tags
    - terminate_tls:          (optional) Boolean specifying if TLS shall be terminated (true) or not (false). Must be true when using destination_urls. Needs Premium SKU for Firewall Policy
    - web_categories:         (optional) Specifies a list of web categories to which access is denied or allowed depending on the value of action above. Needs Premium SKU for Firewall Policy
  DESCRIPTION

  type = map(object({
    action   = optional(string, "Allow")
    priority = number
    rules = optional(map(object({
      description = optional(string, null)

      protocols = list(object({
        type = optional(string, "Https")
        port = optional(number, 443)
      }))

      source_addresses      = optional(list(string), null)
      source_ip_groups      = optional(list(string), null)
      destination_addresses = optional(list(string), null)
      destination_urls      = optional(list(string), null)
      destination_fqdns     = optional(list(string), null)
      destination_fqdn_tags = optional(list(string), null)
      terminate_tls         = optional(bool, null)
      web_categories        = optional(list(string), null)
    })), null)
  }))

  default = null
}
