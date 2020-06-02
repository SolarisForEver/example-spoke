resource "azurerm_virtual_network" "spoke" {
  name                = var.spoke
  resource_group_name = azurerm_resource_group.spoke.name
  location            = azurerm_resource_group.spoke.location
  tags                = azurerm_resource_group.spoke.tags
  address_space       = var.spoke_vnet_address_space
}

resource "azurerm_subnet" "SharedServices" {
  name                 = "SharedServices"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.spoke.address_space[0], 2, 0)]
}

resource "azurerm_subnet" "DomainControllers" {
  name                 = "DomainControllers"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.spoke.address_space[0], 2, 1)]
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet" # Minimum /26
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.spoke.address_space[0], 2, 2)]
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet" # Minimum /27
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.spoke.address_space[0], 3, 6)]
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet" # Minimum /27
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.spoke.address_space[0], 3, 7)]
}
