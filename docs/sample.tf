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
