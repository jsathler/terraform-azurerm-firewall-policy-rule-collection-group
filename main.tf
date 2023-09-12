resource "azurerm_firewall_policy_rule_collection_group" "default" {
  name               = "${var.name}-fwprcg"
  firewall_policy_id = var.firewall_policy_id
  priority           = var.priority

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collections != null ? { for key, value in var.network_rule_collections : key => value } : {}

    content {
      name     = network_rule_collection.key
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority

      dynamic "rule" {
        for_each = network_rule_collection.value.rules != null ? { for key, value in network_rule_collection.value.rules : key => value } : {}

        content {
          name                  = rule.key
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_ip_groups = rule.value.destination_ip_groups
          destination_ports     = rule.value.destination_ports
          destination_fqdns     = rule.value.destination_fqdns
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = var.nat_rule_collection != null ? { for key, value in var.nat_rule_collection : key => value } : {}

    content {
      name     = nat_rule_collection.key
      action   = nat_rule_collection.value.action
      priority = nat_rule_collection.value.priority

      dynamic "rule" {
        for_each = nat_rule_collection.value.rules != null ? { for key, value in nat_rule_collection.value.rules : key => value } : {}

        content {
          name                = rule.key
          protocols           = rule.value.protocols
          source_addresses    = rule.value.source_addresses
          source_ip_groups    = rule.value.source_ip_groups
          destination_address = rule.value.destination_address
          destination_ports   = [rule.value.destination_port]
          translated_address  = rule.value.translated_address
          translated_fqdn     = rule.value.translated_fqdn
          translated_port     = rule.value.translated_port
        }
      }
    }
  }

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collection != null ? { for key, value in var.application_rule_collection : key => value } : {}

    content {
      name     = application_rule_collection.key
      action   = application_rule_collection.value.action
      priority = application_rule_collection.value.priority

      dynamic "rule" {
        for_each = application_rule_collection.value.rules != null ? { for key, value in application_rule_collection.value.rules : key => value } : {}

        content {
          name                  = rule.key
          description           = rule.value.description
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_urls      = rule.value.destination_urls
          destination_fqdns     = rule.value.destination_fqdns
          destination_fqdn_tags = rule.value.destination_fqdn_tags
          terminate_tls         = rule.value.terminate_tls
          web_categories        = rule.value.web_categories

          dynamic "protocols" {
            for_each = rule.value.protocols != null ? rule.value.protocols : []

            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
        }
      }
    }
  }
}
