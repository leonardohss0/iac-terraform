# Provides the Resource Group
resource "azurerm_resource_group" "rg" {
    name = "rg-azure-demo"
    location = "southcentralus"
    tags = {
        source = "Terraform"
    }
}