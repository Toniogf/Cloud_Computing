resource_group_name    = "rg-terraform"
location               = "eastus"
storage_account_name   = "terraformstorage12345"
container_name         = "tfstate"
key                    = "terraform.tfstate"

virtual_network_name   = "vnet-terraform"
address_space          = ["10.0.0.0/16"]

subnet_name            = "subnet-terraform"
subnet_prefixes        = ["10.0.1.0/24"]

network_interface_name = "nic-terraform"

vm_name                = "vm-terraform"
vm_size                = "Standard_B1s"
admin_username         = "azureuser"
ssh_public_key_path    = "~/.ssh/id_rsa.pub"

image_publisher        = "Canonical"
image_offer            = "UbuntuServer"
image_sku              = "18.04-LTS"
image_version          = "latest"
