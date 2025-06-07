#
# Namespace secrets
#
locals {
  secrets_path     = "${var.path}/secrets.yaml"
  env_secrets_path = "${var.path}/secrets.${var.variables.ENVIRONMENT}.yaml"

  secrets_raw = fileexists(local.env_secrets_path) ? yamldecode(
    file(local.env_secrets_path)
    ) : fileexists(local.secrets_path) ? yamldecode(
    file(local.secrets_path)
  ) : null

  secret_names = local.secrets_raw != null ? [
    for name, config in local.secrets_raw : name
  ] : []

  secrets = fileexists(local.env_secrets_path) ? sensitive(yamldecode(
    templatefile(local.env_secrets_path, var.variables)
    )) : fileexists(local.secrets_path) ? sensitive(yamldecode(
    templatefile(local.secrets_path, var.variables)
  )) : null
}

#
# Namespace config maps
#
locals {
  config_path     = "${var.path}/config.yaml"
  env_config_path = "${var.path}/config.${var.variables.ENVIRONMENT}.yaml"

  config_raw = fileexists(local.env_config_path) ? yamldecode(
    file(local.env_config_path)
    ) : fileexists(local.config_path) ? yamldecode(
    file(local.config_path)
  ) : null

  config_names = local.config_raw != null ? [
    for name, config in local.config_raw : name
  ] : []

  config_full = fileexists(local.env_config_path) ? yamldecode(
    templatefile(local.env_config_path, var.variables)
    ) : fileexists(local.config_path) ? yamldecode(
    templatefile(local.config_path, var.variables)
  ) : null

  config = local.config_full != null ? try(
    nonsensitive(local.config_full),
    local.config_full
  ) : null
}
