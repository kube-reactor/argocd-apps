
variable "name" {
  description = "ArgoCD Project name"
  type        = string
}
variable "project_path" {
  description = "Project configuration path"
  type        = string
}

variable "variables" {
  description = "ArgoCD Application interpolation variables"
  type        = any
}

variable "argocd_namespace" {
  description = "ArgoCD Application namespace"
  type        = string
  default     = "argocd"
}

variable "cascade_delete" {
  type        = bool
  description = "Enable / disable cascade deletion of project resources"
  default     = true
}

variable "global_roles" {
  type        = any
  description = "Global ArgoCD roles across all projects"
  default     = {}
}
variable "role_groups" {
  type        = map(list(string))
  description = "ArgoCD Role group membership index"
  default     = {}
}

variable "labels" {
  description = "ArgoCD Project and Application common labels"
  type        = map(any)
  default     = {}
}
variable "annotations" {
  description = "ArgoCD Project and Application common annotations"
  type        = map(any)
  default     = {}
}

variable "ignore_differences" {
  type = list(object({
    kind : string,
    group : string,
    name : string,
    jsonPointers : list(string)
  }))
  description = "Ignore differences at the specified json pointers"
  default     = []
}

variable "revision_history_limit" {
  type        = number
  description = "The number of items kept in the application's revision history"
  default     = 10
}

variable "prune" {
  type        = bool
  description = "Specifies if resources should be pruned during auto-syncing"
  default     = true
}
variable "self_heal" {
  type        = bool
  description = "Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected"
  default     = true
}
variable "allow_empty" {
  type        = bool
  description = "Allows deleting all application resources during automatic syncing"
  default     = false
}
variable "sync_options" {
  type        = list(string)
  description = "A list of sync options to apply to the application"
  default     = []
}
variable "sync_validate" {
  type        = bool
  description = "Disables resource validation (equivalent to 'kubectl apply --validate=true')"
  default     = false
}

variable "sync_replace" {
  type        = bool
  description = "If the Replace=true sync option is set the Argo CD will use kubectl replace or kubectl create command to apply changes."
  default     = false
}

variable "retry_limit" {
  type        = number
  description = "Number of failed sync attempt retries; unlimited number of attempts if less than 0"
  default     = 5
}
variable "retry_backoff_duration" {
  type        = string
  description = "The amount to back off. Default unit is seconds, but could also be a duration (e.g. `2m`, `1h`)"
  default     = "5s"
}
variable "retry_backoff_factor" {
  type        = number
  description = "A factor to multiply the base duration after each failed retry"
  default     = 2
}
variable "retry_backoff_max_duration" {
  type        = string
  description = "The maximum amount of time allowed for the backoff strategy"
  default     = "3m"
}

variable "project_wait" {
  type        = string
  description = "The maximum amount of time allowed for project initialization"
  default     = "30s"
}

variable "destination_server" {
  type        = string
  description = "Destination cluster server url"
  default     = "https://kubernetes.default.svc"
}

variable "default_repository" {
  type        = string
  description = "Default ArgoCD application repository (Git or Helm)"
}
variable "default_chart" {
  type        = string
  description = "Default ArgoCD application Helm chart from Helm repository"
}
variable "default_path" {
  type        = string
  description = "Default ArgoCD application Helm chart from Git repository path"
}
variable "default_version" {
  type        = string
  description = "Default ArgoCD application Helm chart version from Helm repository"
}
