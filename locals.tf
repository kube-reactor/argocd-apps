
locals {
  argocd_name        = "argocd"
  argocd_roles_file  = "${var.argocd_config_path}/roles.yaml"
}

locals {
  core_variables = {
    domain      = var.domain
    environment = var.environment
  }
  variables = merge(var.variables, local.core_variables)
}

locals {
  global_roles = fileexists(local.argocd_roles_file) ? yamldecode(
    templatefile(local.argocd_roles_file, var.variables)
  ) : null
}
