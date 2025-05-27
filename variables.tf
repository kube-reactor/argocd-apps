
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
  default     = "8.0.9"
}

variable "argocd_config_path" { # CI/CD project directory
  description = "ArgoCD configuration path"
  type        = string
}
variable "project_path" { # CI/CD project directory
  description = "Base project configuration path"
  type        = string
}
variable "config_path" { # Local directory
  description = "Project configuration additions path (non-versioned)"
  type        = string
  default     = ""
}

variable "project_sequence" {
  description = "Ordered collections of ArgoCD Application projects (up to 10 projects supported)"
  type        = list(any)
}

variable "project_wait" {
  type        = string
  description = "The maximum amount of time allowed for project initialization"
  default     = "30s"
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
  default     = "https://charts.kube-reactor.com"
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
  default     = "2.0.2"
}
