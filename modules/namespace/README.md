<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [kubernetes_config_map.config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)     | resource |
| [kubernetes_secret.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)        | resource |

## Inputs

| Name                                                               | Description                                                                  | Type       | Default | Required |
| ------------------------------------------------------------------ | ---------------------------------------------------------------------------- | ---------- | ------- | :------: |
| <a name="input_annotations"></a> [annotations](#input_annotations) | Kubernetes namespace annotations                                             | `map(any)` | `{}`    |    no    |
| <a name="input_application"></a> [application](#input_application) | Kubernetes ArgoCD application name                                           | `string`   | n/a     |   yes    |
| <a name="input_exists"></a> [exists](#input_exists)                | If Kubernetes namespace already exists (only create secrets and config maps) | `bool`     | `false` |    no    |
| <a name="input_labels"></a> [labels](#input_labels)                | Kubernetes namespace labels                                                  | `map(any)` | `{}`    |    no    |
| <a name="input_name"></a> [name](#input_name)                      | Kubernetes namespace name                                                    | `string`   | n/a     |   yes    |
| <a name="input_path"></a> [path](#input_path)                      | Project path that contains secrets and config files                          | `string`   | n/a     |   yes    |
| <a name="input_variables"></a> [variables](#input_variables)       | Interpolation variables                                                      | `any`      | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
