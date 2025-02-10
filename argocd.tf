
module "argocd" {
  source = "./modules/namespace"

  name        = local.argocd_name
  application = local.argocd_name
  path        = var.argocd_config_path
  config_path = var.config_path
  variables   = local.variables
}

resource "helm_release" "argocd" {
  name       = local.argocd_name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = local.argocd_name

  force_update      = true
  dependency_update = true
  reuse_values      = false
  create_namespace  = false

  wait          = true
  wait_for_jobs = true

  values = fileexists("${var.argocd_config_path}/values.${var.variables.environment}.yaml") ? try(
    nonsensitive(templatefile("${var.argocd_config_path}/values.${var.variables.environment}.yaml", var.variables)),
    templatefile("${var.argocd_config_path}/values.${var.variables.environment}.yaml", var.variables)
    ) : fileexists("${var.argocd_config_path}/values.yaml") ? try(
    nonsensitive(templatefile("${var.argocd_config_path}/values.yaml", var.variables)),
    templatefile("${var.argocd_config_path}/values.yaml", var.variables)
  ) : null

  depends_on = [
    module.argocd
  ]
}
