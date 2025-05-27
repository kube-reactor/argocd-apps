
resource "kubernetes_config_map" "config" {
  for_each = try(nonsensitive(local.config_names), local.config_names)

  metadata {
    name      = each.value
    namespace = var.name

    labels      = local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "labels", null) : null) : null
    annotations = local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "annotations", null) : null) : null
  }

  immutable   = local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "immutable", null) : null) : null
  data        = local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "data", null) : null) : null
  binary_data = local.config != null ? (lookup(local.config, each.value, null) != null ? lookup(local.config[each.value], "binary", null) : null) : null

  depends_on = [
    kubernetes_namespace.this
  ]
}
