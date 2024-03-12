variable subscription_id {
    type = string
    default = "74c2e3ac-be44-401a-acea-768ddd167a5f"
}
variable tenant_id {
    type = string
    default = "c74940ec-9df1-429e-9e18-5ee10c445e4f"
}

variable "location" {
  type = string
  default = "westus2"
}

variable "rg_name" {
  type = string
  default = "rg-cooltfresourcegroup"
}