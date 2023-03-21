
#
# System variables
#
variable "domain" { # CI/CD global config
  description = "Platform domain"
  type        = string
}
variable "environment" { # CI/CD pipeline config
  description = "Platform Environment"
  type        = string
}

#
# ArgoCD variables
#
variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.19.4"
}

variable "argocd_config_path" { # CI/CD project directory
  description = "ArgoCD configuration path"
  type        = string
}
variable "project_path" { # CI/CD project directory
  description = "Base project configuration path"
  type        = string
}
variable "project_sequence" {
  description = "Ordered collections of ArgoCD Application projects (up to 10 projects supported)"
  type        = list
}

variable "role_groups" {
  type        = map(list(string))
  description = "ArgoCD Role group membership index"
  default     = {}
}
variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
  default     = {}
}

#
# Application variables
#
variable "default_repository" {
  type        = string
  description = "Default ArgoCD application repository (Git or Helm)"
  default     = "https://charts.zimagi.com"
}
variable "default_chart" {
  type        = string
  description = "Default ArgoCD application Helm chart from Helm repository"
  default     = "application"
}
variable "default_path" {
  type        = string
  description = "Default ArgoCD application Helm chart from Git repository path"
  default     = null
}
variable "default_version" {
  type        = string
  description = "Default ArgoCD application Helm chart version from Helm repository"
  default     = "1.1.2"
}
