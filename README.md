<!-- BEGIN_TF_DOCS -->
# Azure Firewall Policy rule collection group Terraform module

Terraform module which creates Azure Firewall Policy rule collection groups on Azure.

Supported Azure services:

* [Azure Firewall Policy rule sets](https://learn.microsoft.com/en-us/azure/firewall/policy-rule-sets)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy_rule_collection_group.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection"></a> [application\_rule\_collection](#input\_application\_rule\_collection) | - action:                   (optional) The action to take for the application rules in this collection. Possible values are Allow and Deny. Defaults to 'Allow'<br>  - priority:                 (required) The priority of the application rule collection. The range is 100-65000 and should be unique within this collection group<br>  - rules:                    (optional) One or more application\_rule (rules) blocks as defined below<br>    - protocols:              (optional) One or more protocols blocks as defined below<br>      - type:                 (required) Protocol type. Possible values are Http and Https. Defaults to 'Https'<br>      - port:                 (required) Port number of the protocol. Range is 0-64000. Defaults to '443'<br>    - description:            (optional) The description which should be used for this rule<br>    - source\_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)<br>    - source\_ip\_groups:       (optional) Specifies a list of source IP groups<br>    - destination\_addresses:  (optional) Specifies a list of destination IP addresses (including CIDR, IP range and *)<br>    - destination\_urls:       (optional) Specifies a list of destination URLs for which policy should hold. Needs Premium SKU for Firewall Policy. Conflicts with destination\_fqdns<br>    - destination\_fqdns:      (optional) Specifies a list of destination FQDNs. Conflicts with destination\_urls<br>    - destination\_fqdn\_tags:  (optional) Specifies a list of destination FQDN tags<br>    - terminate\_tls:          (optional) Boolean specifying if TLS shall be terminated (true) or not (false). Must be true when using destination\_urls. Needs Premium SKU for Firewall Policy<br>    - web\_categories:         (optional) Specifies a list of web categories to which access is denied or allowed depending on the value of action above. Needs Premium SKU for Firewall Policy | <pre>map(object({<br>    action   = optional(string, "Allow")<br>    priority = number<br>    rules = optional(map(object({<br>      description = optional(string, null)<br><br>      protocols = list(object({<br>        type = optional(string, "Https")<br>        port = optional(number, 443)<br>      }))<br><br>      source_addresses      = optional(list(string), null)<br>      source_ip_groups      = optional(list(string), null)<br>      destination_addresses = optional(list(string), null)<br>      destination_urls      = optional(list(string), null)<br>      destination_fqdns     = optional(list(string), null)<br>      destination_fqdn_tags = optional(list(string), null)<br>      terminate_tls         = optional(bool, null)<br>      web_categories        = optional(list(string), null)<br>    })), null)<br>  }))</pre> | `null` | no |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | The ID of an existing Firewall Policy where new rules will be created. This parameter is required | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this Firewall Policy Rule Collection Group. This parameter is required | `string` | n/a | yes |
| <a name="input_nat_rule_collection"></a> [nat\_rule\_collection](#input\_nat\_rule\_collection) | - action:                   (optional) The action to take for the NAT rules in this collection. Currently, the only possible value is Dnat. Defaults to 'Dnat'<br>  - priority:                 (required) The priority of the nat rule collection. The range is 100-65000 and should be unique within this collection group<br>  - rules:                    (required) One or more nat\_rule (rules) blocks as defined below<br>    - protocols:              (optional) Specifies a list of network protocols this rule applies to. Possible values are TCP and UDP. Defaults to 'TCP'<br>    - source\_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)<br>    - source\_ip\_groups:       (optional) Specifies a list of source IP groups<br>    - destination\_address:    (required) The destination IP address (including CIDR)<br>    - destination\_port:       (required) Specifies the destination port<br>    - translated\_address:     (optional) Specifies the translated address<br>    - translated\_fqdn:        (optional) Specifies the translated FQDN<br>    - translated\_port:        (Required) Specifies the translated port | <pre>map(object({<br>    action   = optional(string, "Dnat")<br>    priority = number<br>    rules = map(object({<br>      protocols           = optional(list(string), ["TCP"])<br>      source_addresses    = optional(list(string), null)<br>      source_ip_groups    = optional(list(string), null)<br>      destination_address = string<br>      destination_port    = number<br>      translated_address  = optional(string, null)<br>      translated_fqdn     = optional(string, null)<br>      translated_port     = number<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | - action:                   (optional) The action to take for the network rules in this collection. Possible values are Allow and Deny. Defaults to 'Allow'<br>  - priority:                 (required) The priority of the network rule collection. The range is 100-65000 and should be unique within this collection group<br>  - rules:                    (optional) One or more network\_rule (rules) blocks as defined below<br>    - protocols:              (optional) Specifies a list of network protocols this rule applies to. Possible values are Any, TCP, UDP, ICMP. Defaults to 'TCP'<br>    - destination\_ports:      (required) Specifies a list of destination ports<br>    - source\_addresses:       (optional) Specifies a list of source IP addresses (including CIDR, IP range and *)<br>    - source\_ip\_groups:       (optional) Specifies a list of source IP groups<br>    - destination\_addresses:  (optional) Specifies a list of destination IP addresses (including CIDR, IP range and *) or Service Tags<br>    - destination\_ip\_groups:  (optional) Specifies a list of destination IP groups<br>    - destination\_fqdns:      (optional) Specifies a list of destination FQDNs | <pre>map(object({<br>    action   = optional(string, "Allow")<br>    priority = number<br>    rules = optional(map(object({<br>      protocols             = optional(list(string), ["TCP"])<br>      destination_ports     = list(string)<br>      source_addresses      = optional(list(string), null)<br>      source_ip_groups      = optional(list(string), null)<br>      destination_addresses = optional(list(string), null)<br>      destination_ip_groups = optional(list(string), null)<br>      destination_fqdns     = optional(list(string), null)<br>    })), null)<br>  }))</pre> | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the Firewall Policy Rule Collection Group. The range is 100-65000 and should be unique within the firewall policy. This parameter is required | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collection_group_id"></a> [collection\_group\_id](#output\_collection\_group\_id) | n/a |
| <a name="output_collection_group_name"></a> [collection\_group\_name](#output\_collection\_group\_name) | n/a |

## Examples
```hcl
module "firewall-policy-global-rules" {
  source             = "jsathler/firewall-policy-rule-collection-group/azurerm"
  name               = "global-rules"
  firewall_policy_id = module.firewall-policy.policy_id
  priority           = 100
  network_rule_collections = {
    net-global-blacklist = {
      action   = "Deny"
      priority = 100
      rules = {
        unsecure1 = { source_addresses = [local.local_subnet], destination_addresses = ["100.100.100.100", "100.100.100.101"], protocols = ["Any"], destination_ports = ["*"] }
        unsecure2 = { source_addresses = [local.local_subnet], destination_addresses = ["200.200.200.200", "200.200.200.201"], protocols = ["Any"], destination_ports = ["*"] }
      }
    }
    net-global-default = {
      priority = 105
      rules = {
        ntp            = { source_addresses = [local.local_subnet], destination_addresses = ["pool.ntp.org"], protocols = ["UDP"], destination_ports = ["123"] }
        icmp           = { source_addresses = [local.local_subnet], destination_addresses = [local.local_subnet], protocols = ["ICMP"], destination_ports = ["*"] }
        authentication = { source_addresses = [local.local_subnet], destination_addresses = local.adds_servers, protocols = ["TCP", "UDP"], destination_ports = ["53", "88", "123", "135", "137", "138", "139", "389", "445", "464", "636", "3268", "3269", "49152-65535"] }
      }
    }
  }
  application_rule_collection = {
    app-global-blacklist = {
      action   = "Deny"
      priority = 130
      rules = {
        webcategories = { source_addresses = [local.local_subnet], web_categories = ["CriminalActivity"], protocols = [{}, { type = "Http", port = "80" }] }
      }
    }
    app-global-default = {
      priority = 135
      rules = {
        windowsupdate = { source_addresses = [local.local_subnet], destination_fqdn_tags = ["WindowsUpdate"], protocols = [{}] }
      }
    }
  }
}
```
More examples in ./examples folder
<!-- END_TF_DOCS -->