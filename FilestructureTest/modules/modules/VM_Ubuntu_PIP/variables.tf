variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "pip_name" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
    default = "Standard_DS1_v2"
}

variable "admin_username" {
  type = string
  default = "jfluckiger"
}

variable "admin_password" {
  type = string
  default = "Super123!"
}

