resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argocd_deploy" {
  depends_on = [kubernetes_namespace.argocd]
  name       = "argo-cd"
  chart      = "argo-cd"
  timeout    = 600
  version    = var.chart_version
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  values = [
    templatefile("${path.module}/templates/values.yaml.tpl",
      {
        issuer_name         = var.issuer_name
        hostname            = var.argocd_config.hostname
        redis_ha_enable     = var.argocd_config.redis_ha_enabled
        autoscaling_enabled = var.argocd_config.autoscaling_enabled
        ingress_class_name  = var.argocd_config.ingress_class_name
      }
    )
  ]
}

data "kubernetes_secret" "argocd-secret" {
  depends_on = [helm_release.argocd_deploy]
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
}

output "argocd" {
  description = "Argocd_Info"
  value = {
    username = "admin",
    password = nonsensitive(data.kubernetes_secret.argocd-secret.data.password),
    url      = var.argocd_config.hostname
  }
}
