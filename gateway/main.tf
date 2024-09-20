module "kubernetes_apps" {
  source = "./.."

  domain      = var.domain
  environment = var.environment

  role_groups        = local.access_config.argocd
  argocd_config_path = "${var.project_path}/argocd"
  project_path       = "${var.project_path}/projects"

  project_sequence = var.argocd_project_sequence
  variables        = local.variables
}
