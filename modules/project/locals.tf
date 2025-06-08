
#
# Configuration and application data
#
locals {
  applications = {
    for file in fileset(var.project_path, "*/info.yaml") :
    dirname(file) => yamldecode(templatefile("${var.project_path}/${file}", var.variables))
  }

  enabled_applications = {
    for path, config in local.applications : path => config
    if contains(lookup(config, "enabled", []), "all")
    || contains(lookup(config, "enabled", []), var.variables.ENVIRONMENT)
  }

  roles = {
    for path, config in local.enabled_applications :
    config.name => fileexists("${var.project_path}/${path}/roles.yaml")
    ? yamldecode(templatefile("${var.project_path}/${path}/roles.yaml", var.variables))
    : null
  }
}

#
# Kubernetes manifests
#
locals {
  #
  # ArgoCD Project
  #
  project_manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"

    metadata = {
      name        = var.name
      namespace   = var.argocd_namespace
      labels      = var.labels
      annotations = var.annotations
      finalizers  = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    }
    spec = {
      sourceRepos = ["*"]
      destinations = [
        {
          name      = "in-cluster"
          namespace = "*"
          server    = "https://kubernetes.default.svc"
        }
      ]
      clusterResourceWhitelist = [
        {
          group = "*"
          kind  = "*"
        }
      ]

      roles = flatten(concat([
        for app_name, app_config in local.roles : [
          for role_name, config in coalesce(app_config, {}) : {
            name        = role_name,
            description = config.description,
            policies = flatten([
              for resource, policy in config.policies : [
                for action in policy.actions : [
                  lookup(policy, "resource", resource) == "applications"
                  ? "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${var.name}/${app_name}, allow"
                  : "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${app_name}, allow"
                ]
              ]
            ]),
            groups = lookup(var.role_groups, role_name, [])
          }
        ]
        ], [
        for role_name, config in coalesce(var.global_roles, {}) : {
          name        = role_name,
          description = config.description,
          policies = flatten([
            for resource, policy in config.policies : [
              for action in policy.actions : [
                for obj in lookup(policy, "objects", ["*"]) :
                lookup(policy, "resource", resource) == "applications"
                ? "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${var.name}/${obj}, allow"
                : "p, proj:${var.name}:${role_name}, ${lookup(policy, "resource", resource)}, ${action}, ${obj}, allow"
              ]
            ]
          ]),
          groups = lookup(var.role_groups, role_name, [])
        }
      ]))
    }
  }

  #
  # ArgoCD Application
  #
  application_manifests = {
    for path, config in local.enabled_applications :
    config.name => {
      apiVersion = "argoproj.io/v1alpha1"
      kind       = "Application"

      metadata = {
        name        = config.name
        namespace   = var.argocd_namespace
        labels      = merge(var.labels, lookup(config, "labels", {}))
        annotations = merge(var.annotations, lookup(config, "annotations", {}))
        finalizers  = var.cascade_delete == true ? ["resources-finalizer.argocd.argoproj.io"] : []
      }
      spec = {
        project              = var.name
        ignoreDifferences    = lookup(config, "ignore_differences", var.ignore_differences)
        revisionHistoryLimit = lookup(config, "revision_history_limit", var.revision_history_limit)

        syncPolicy = {
          automated = {
            prune      = lookup(config, "prune", var.prune)
            selfHeal   = lookup(config, "self_heal", var.self_heal)
            allowEmpty = lookup(config, "allow_empty", var.allow_empty)
          }
          syncOptions = concat(lookup(config, "sync_options", var.sync_options), [
            lookup(config, "sync_validate", var.sync_validate) ? "Validate=true" : "Validate=false",
            lookup(config, "sync_replace", var.sync_replace) ? "Replace=true" : "Replace=false",
            lookup(config, "sync_rerver_side_apply", false) ? "ServerSideApply=true" : "ServerSideApply=false",
            "CreateNamespace=false"
          ])
          retry = {
            limit = lookup(config, "retry_limit", var.retry_limit)
            backoff = {
              duration    = lookup(config, "retry_backoff_duration", var.retry_backoff_duration)
              factor      = lookup(config, "retry_backoff_factor", var.retry_backoff_factor)
              maxDuration = lookup(config, "retry_backoff_max_duration", var.retry_backoff_max_duration)
            }
          }
        }

        source = {
          repoURL        = lookup(config, "repository", var.default_repository)
          chart          = lookup(config, "chart", null)            # Helm Repository only
          path           = lookup(config, "path", var.default_path) # Git Repository only
          targetRevision = lookup(config, "version", var.default_version)

          helm = lookup(config, "chart", null) != null || fileexists("${var.project_path}/${path}/values.${var.variables.ENVIRONMENT}.yaml") || fileexists("${var.project_path}/${path}/values.yaml") ? {
            releaseName     = lookup(config, "release", config.name)
            passCredentials = lookup(config, "pass_credentials", false)
            skipCrds        = lookup(config, "skipCrds", false)
            values = fileexists("${var.project_path}/${path}/values.${var.variables.ENVIRONMENT}.yaml") ? try(
              nonsensitive(templatefile("${var.project_path}/${path}/values.${var.variables.ENVIRONMENT}.yaml", var.variables)),
              templatefile("${var.project_path}/${path}/values.${var.variables.ENVIRONMENT}.yaml", var.variables)
              ) : fileexists("${var.project_path}/${path}/values.yaml") ? try(
              nonsensitive(templatefile("${var.project_path}/${path}/values.yaml", var.variables)),
              templatefile("${var.project_path}/${path}/values.yaml", var.variables)
            ) : ""
          } : null
        }

        destination = {
          server    = lookup(config, "destination_server", var.destination_server)
          namespace = lookup(config, "namespace", config.name)
        }
      }
    }
  }
}
