#
# This is not a great solution but Terraform doesn't support
# dependency chaining within resource blocks for concurrency
# reasons
#
# Support up to 10 deployment stages (which should be plenty)
#
module "project_0" {
  count = length(var.project_sequence) > 0 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[0]
  project_path = "${var.project_path}/${var.project_sequence[0]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    helm_release.argocd
  ]
}

module "project_1" {
  count = length(var.project_sequence) > 1 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[1]
  project_path = "${var.project_path}/${var.project_sequence[1]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_0
  ]
}

module "project_2" {
  count = length(var.project_sequence) > 2 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[2]
  project_path = "${var.project_path}/${var.project_sequence[2]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_1
  ]
}

module "project_3" {
  count = length(var.project_sequence) > 3 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[3]
  project_path = "${var.project_path}/${var.project_sequence[3]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_2
  ]
}

module "project_4" {
  count = length(var.project_sequence) > 4 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[4]
  project_path = "${var.project_path}/${var.project_sequence[4]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_3
  ]
}

module "project_5" {
  count = length(var.project_sequence) > 5 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[5]
  project_path = "${var.project_path}/${var.project_sequence[5]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_4
  ]
}

module "project_6" {
  count = length(var.project_sequence) > 6 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[6]
  project_path = "${var.project_path}/${var.project_sequence[6]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_5
  ]
}

module "project_7" {
  count = length(var.project_sequence) > 7 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[7]
  project_path = "${var.project_path}/${var.project_sequence[7]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_6
  ]
}

module "project_8" {
  count = length(var.project_sequence) > 8 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[8]
  project_path = "${var.project_path}/${var.project_sequence[8]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_7
  ]
}

module "project_9" {
  count = length(var.project_sequence) > 9 ? 1 : 0

  source       = "./modules/project"
  name         = var.project_sequence[9]
  project_path = "${var.project_path}/${var.project_sequence[9]}"
  project_wait = var.project_wait
  global_roles = local.global_roles
  role_groups  = var.role_groups

  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.project_8
  ]
}
