
#
# Kubernetes provider setup
#
provider "kubernetes" {
  config_path = var.kube_config
}
