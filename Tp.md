# Guide d'utilisation Terraform

---

## 1. Initialiser le dossier Terraform

```
terraform init
```
```
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching ">= 3.77.0"...
- Installing hashicorp/azurerm v3.77.0...
- Installed hashicorp/azurerm v3.77.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration, rerun this command
to reinitialize your working directory. If you forget, other commands will
detect it and remind you to do so if necessary.
```

## 2. Simuler la création des ressources (plan)
```
terraform plan
```
```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

...
Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "rg-terraform"
    }

  # azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "vnet-terraform"
      + resource_group_name = "rg-terraform"
    }

  # azurerm_subnet.subnet will be created
  + resource "azurerm_subnet" "subnet" {
      + address_prefixes     = [
          + "10.0.1.0/24",
        ]
      + id                  = (known after apply)
      + name                = "subnet-terraform"
      + resource_group_name = "rg-terraform"
      + virtual_network_name = "vnet-terraform"
    }

  # azurerm_network_interface.nic will be created
  + resource "azurerm_network_interface" "nic" {
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "nic-terraform"
      + resource_group_name = "rg-terraform"

      + ip_configuration {
          + name                          = "ipconfig1"
          + private_ip_address_allocation = "Dynamic"
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_linux_virtual_machine.vm will be created
  + resource "azurerm_linux_virtual_machine" "vm" {
      + admin_username           = "azureuser"
      + id                       = (known after apply)
      + location                 = "eastus"
      + name                     = "vm-terraform"
      + resource_group_name      = "rg-terraform"
      + size                     = "Standard_B1s"
      + network_interface_ids    = [
          + (known after apply),
        ]
      + os_disk {
          + caching              = "ReadWrite"
          + storage_account_type = "Standard_LRS"
        }
      + source_image_reference {
          + publisher = "Canonical"
          + offer     = "UbuntuServer"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }
    }

Plan: 5 to add, 0 to change, 0 to destroy.
```

## 3 Appliquer la configuration (création des ressources)
```
terraform apply
```
```
Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  ...
Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 2s [id=/subscriptions/xxxx/resourceGroups/rg-terraform]

azurerm_virtual_network.vnet: Creating...
azurerm_subnet.subnet: Creating...
azurerm_network_interface.nic: Creating...
azurerm_virtual_network.vnet: Creation complete after 3s [id=/subscriptions/xxxx/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform]
azurerm_subnet.subnet: Creation complete after 2s [id=/subscriptions/xxxx/resourceGroups/rg-terraform/providers/Microsoft.Network/virtualNetworks/vnet-terraform/subnets/subnet-terraform]
azurerm_network_interface.nic: Creation complete after 2s [id=/subscriptions/xxxx/resourceGroups/rg-terraform/providers/Microsoft.Network/networkInterfaces/nic-terraform]

azurerm_linux_virtual_machine.vm: Creating...
azurerm_linux_virtual_machine.vm: Still creating... [10s elapsed]
azurerm_linux_virtual_machine.vm: Creation complete after 1m [id=/subscriptions/xxxx/resourceGroups/rg-terraform/providers/Microsoft.Compute/virtualMachines/vm-terraform]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

```

## 4. Supprimer les ressources créées
```
terraform destroy
```
```
Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.vm will be destroyed
  # azurerm_network_interface.nic will be destroyed
  # azurerm_subnet.subnet will be destroyed
  # azurerm_virtual_network.vnet will be destroyed
  # azurerm_resource_group.rg will be destroyed

Plan: 0 to add, 0 to change, 5 to destroy.

Do you really want to destroy all resources?
  Only 'yes' will be accepted to confirm.

Enter a value: yes

azurerm_linux_virtual_machine.vm: Destroying... [id=...]
azurerm_linux_virtual_machine.vm: Destruction complete after 20s
azurerm_network_interface.nic: Destroying... [id=...]
azurerm_network_interface.nic: Destruction complete after 5s
azurerm_subnet.subnet: Destroying... [id=...]
azurerm_subnet.subnet: Destruction complete after 5s
azurerm_virtual_network.vnet: Destroying... [id=...]
azurerm_virtual_network.vnet: Destruction complete after 5s
azurerm_resource_group.rg: Destroying... [id=...]
azurerm_resource_group.rg: Destruction complete after 3s

Destroy complete! Resources: 5 destroyed.
```
