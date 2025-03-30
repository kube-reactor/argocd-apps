provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  config_path = var.kube_config_path
}

provider "kubectl" {
  config_path = var.kube_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}

module "kubernetes_apps" {
  source = "../../../.."

  domain      = var.global_root_domain
  environment = var.global_environment

  role_groups        = local.access_config.argocd
  argocd_config_path = "${var.project_path}/argocd"
  project_path       = "${var.project_path}/projects"

  project_sequence = [
    "helm",
    "git-folder",
    "databases"
  ]

  variables = local.variables
}
