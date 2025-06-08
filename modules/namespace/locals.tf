#
# Namespace secrets
#
locals {
  secrets_path         = "${var.path}/secrets.yaml"
  secrets_file_content = fileexists(local.secrets_path) ? file(local.secrets_path) : ""

  env_secrets_path         = "${var.path}/secrets.${var.variables.ENVIRONMENT}.yaml"
  env_secrets_file_content = fileexists(local.env_secrets_path) ? file(local.env_secrets_path) : ""

  secrets = fileexists(local.env_secrets_path) ? (length(local.env_secrets_file_content) > 0 ? sensitive(yamldecode(
    templatefile(local.env_secrets_path, var.variables)
    )) : null) : fileexists(local.secrets_path) ? (length(local.secrets_file_content) > 0 ? sensitive(yamldecode(
    templatefile(local.secrets_path, var.variables)
  )) : null) : null

  secret_names = local.secrets != null ? [
    for name, config in local.secrets : name
  ] : []
}

#
# Namespace config maps
#
locals {
  config_path         = "${var.path}/config.yaml"
  config_file_content = fileexists(local.config_path) ? file(local.config_path) : ""

  env_config_path         = "${var.path}/config.${var.variables.ENVIRONMENT}.yaml"
  env_config_file_content = fileexists(local.env_config_path) ? file(local.env_config_path) : ""

  config_full = fileexists(local.env_config_path) ? (length(local.env_config_file_content) > 0 ? yamldecode(
    templatefile(local.env_config_path, var.variables)
    ) : null) : fileexists(local.config_path) ? (length(local.config_file_content) > 0 ? yamldecode(
    templatefile(local.config_path, var.variables)
  ) : null) : null

  config = local.config_full != null ? try(
    nonsensitive(local.config_full),
    local.config_full
  ) : null

  config_names = local.config != null ? [
    for name, config in local.config : name
  ] : []
}
