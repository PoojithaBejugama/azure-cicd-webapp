variable "resource_group_name" {
  description = "name of rg"
  type = string
  default = "rg-devops-newProject-demo"
} 

variable "location" {
  type = string
  default = "Canada Central"        
}

variable "environment" {
  type = string
  default = "dev"
}

