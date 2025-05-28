module "argocd" {
  source      = "./argocd"
  issuer_name = var.issuer_name
  argocd_config = {
    hostname            = var.argocd_server_host
    redis_ha_enabled    = var.redis_ha_enable
    autoscaling_enabled = var.autoscaling_enabled
    ingress_class_name  = var.ingress_class_name
  }
}