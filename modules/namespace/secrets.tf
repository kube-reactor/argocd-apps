
resource "kubernetes_secret" "secrets" {
  for_each = try(nonsensitive(local.secret_names), local.secret_names)

  metadata {
    name      = each.value
    namespace = var.name

    labels      = local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "labels", null) : null) : null
    annotations = local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "annotations", null) : null) : null
  }

  type        = local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "type", null) : null) : null
  immutable   = local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "immutable", null) : null) : null
  data        = sensitive(local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "data", null) : null) : null)
  binary_data = sensitive(local.secrets != null ? (lookup(local.secrets, each.value, null) != null ? lookup(local.secrets[each.value], "binary", null) : null) : null)

  depends_on = [
    kubernetes_namespace.this
  ]
}
