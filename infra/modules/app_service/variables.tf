variable "plan_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B1"
}

variable "node_version" {
  type    = string
  default = "18-lts"
}