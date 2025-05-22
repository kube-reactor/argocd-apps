<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                                | Version |
| --------------------------------------------------- | ------- |
| <a name="provider_helm"></a> [helm](#provider_helm) | n/a     |

## Modules

| Name                                                           | Source              | Version |
| -------------------------------------------------------------- | ------------------- | ------- |
| <a name="module_argocd"></a> [argocd](#module_argocd)          | ./modules/namespace | n/a     |
| <a name="module_project_0"></a> [project_0](#module_project_0) | ./modules/project   | n/a     |
| <a name="module_project_1"></a> [project_1](#module_project_1) | ./modules/project   | n/a     |
| <a name="module_project_2"></a> [project_2](#module_project_2) | ./modules/project   | n/a     |
| <a name="module_project_3"></a> [project_3](#module_project_3) | ./modules/project   | n/a     |
| <a name="module_project_4"></a> [project_4](#module_project_4) | ./modules/project   | n/a     |
| <a name="module_project_5"></a> [project_5](#module_project_5) | ./modules/project   | n/a     |
| <a name="module_project_6"></a> [project_6](#module_project_6) | ./modules/project   | n/a     |
| <a name="module_project_7"></a> [project_7](#module_project_7) | ./modules/project   | n/a     |
| <a name="module_project_8"></a> [project_8](#module_project_8) | ./modules/project   | n/a     |
| <a name="module_project_9"></a> [project_9](#module_project_9) | ./modules/project   | n/a     |

## Resources

| Name                                                                                                        | Type     |
| ----------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name                                                                                    | Description                                                                      | Type                | Default                             | Required |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------- | ----------------------------------- | :------: |
| <a name="input_argocd_config_path"></a> [argocd_config_path](#input_argocd_config_path) | ArgoCD configuration path                                                        | `string`            | n/a                                 |   yes    |
| <a name="input_argocd_version"></a> [argocd_version](#input_argocd_version)             | ArgoCD Helm chart version                                                        | `string`            | `"7.7.6"`                           |    no    |
| <a name="input_config_path"></a> [config_path](#input_config_path)                      | Project configuration additions path (non-versioned)                             | `string`            | `""`                                |    no    |
| <a name="input_default_chart"></a> [default_chart](#input_default_chart)                | Default ArgoCD application Helm chart from Helm repository                       | `string`            | `"application"`                     |    no    |
| <a name="input_default_path"></a> [default_path](#input_default_path)                   | Default ArgoCD application Helm chart from Git repository path                   | `string`            | `null`                              |    no    |
| <a name="input_default_repository"></a> [default_repository](#input_default_repository) | Default ArgoCD application repository (Git or Helm)                              | `string`            | `"https://charts.kube-reactor.com"` |    no    |
| <a name="input_default_version"></a> [default_version](#input_default_version)          | Default ArgoCD application Helm chart version from Helm repository               | `string`            | `"2.0.1"`                           |    no    |
| <a name="input_domain"></a> [domain](#input_domain)                                     | Platform domain                                                                  | `string`            | n/a                                 |   yes    |
| <a name="input_environment"></a> [environment](#input_environment)                      | Platform Environment                                                             | `string`            | n/a                                 |   yes    |
| <a name="input_project_path"></a> [project_path](#input_project_path)                   | Base project configuration path                                                  | `string`            | n/a                                 |   yes    |
| <a name="input_project_sequence"></a> [project_sequence](#input_project_sequence)       | Ordered collections of ArgoCD Application projects (up to 10 projects supported) | `list(any)`         | n/a                                 |   yes    |
| <a name="input_project_wait"></a> [project_wait](#input_project_wait)                   | The maximum amount of time allowed for project initialization                    | `string`            | `"30s"`                             |    no    |
| <a name="input_role_groups"></a> [role_groups](#input_role_groups)                      | ArgoCD Role group membership index                                               | `map(list(string))` | `{}`                                |    no    |
| <a name="input_variables"></a> [variables](#input_variables)                            | ArgoCD Application interpolation variables                                       | `any`               | `{}`                                |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
