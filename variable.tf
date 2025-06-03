variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "rg-terraform"
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Nom du compte de stockage (unique)"
  type        = string
  default     = "terraformstorage12345"
}

variable "container_name" {
  description = "Nom du container blob"
  type        = string
  default     = "tfstate"
}

variable "key" {
  description = "Nom du fichier de state Terraform"
  type        = string
  default     = "terraform.tfstate"
}

variable "virtual_network_name" {
  description = "Nom du réseau virtuel"
  type        = string
  default     = "vnet-terraform"
}

variable "address_space" {
  description = "Plage d'adresses du réseau virtuel"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nom du sous-réseau"
  type        = string
  default     = "subnet-terraform"
}

variable "subnet_prefixes" {
  description = "Plage d'adresses du sous-réseau"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "network_interface_name" {
  description = "Nom de l'interface réseau"
  type        = string
  default     = "nic-terraform"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
  default     = "vm-terraform"
}

variable "vm_size" {
  description = "Taille de la machine virtuelle"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Nom d'utilisateur admin pour la VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Chemin vers la clé publique SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "image_publisher" {
  description = "Publisher de l'image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer de l'image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU de l'image"
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version de l'image"
  type        = string
  default     = "latest"
}
