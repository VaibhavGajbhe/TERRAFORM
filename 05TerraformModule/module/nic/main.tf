resource "azurerm_public_ip" "public-ip-block" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = "rg-create-map01"
  location            = "japanwest"
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "NIC-Block" {
  for_each            = var.nic-Create
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name =                        "internal"
    subnet_id                     = "/subscriptions/6636e947-9f19-4998-a24c-7ddd8d02f2c4/resourceGroups/rg-create-map01/providers/Microsoft.Network/virtualNetworks/module-Vnet/subnets/frontendSubnet"
    # ip_configuration              = ""
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip-block.id
  }
}
