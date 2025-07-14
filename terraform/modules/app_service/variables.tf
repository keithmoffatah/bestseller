variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "unique_suffix" {
  description = "A unique suffix to ensure global uniqueness of the app service name."
  type        = string
}
