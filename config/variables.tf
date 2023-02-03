
variable "config_path" {
  description = "Base configuration path"
  type        = string
}
variable "values_directory" {
  description = "Helm values directory within the base application configuration path (config_path)"
  type        = string
}

variable "group" {
  description = "ArgoCD Application group"
  type        = string
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
}

locals {
  applications = [
    for file in fileset(var.config_path, "${var.group}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", var.variables))
  ]
}
