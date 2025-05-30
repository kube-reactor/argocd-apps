locals {
  access_config = yamldecode(file("${var.project_path}/access.yml"))

  oauth_emails = tolist(toset(flatten([
    for group, emails in local.access_config.ingress : emails
  ])))

  oauth_access_groups = {
    for group, emails in local.access_config.ingress :
    group => join(",", emails)
  }
}

#
# Application variables
#
locals {
  variables = merge(var.variables, sensitive({
    DOMAIN                = var.domain
    ENVIRONMENT           = var.environment
    PROJECT_PATH          = var.project_path
    KUBE_CONFIG           = var.kube_config
    ARGOCD_ADMIN_PASSWORD = var.argocd_admin_password
    OAUTH_ACCESS_EMAILS   = join("\\n", local.oauth_emails)
    oauth_access_groups   = local.oauth_access_groups
  }))
}
