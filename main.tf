module "argocd" {
  source = "./argocd"
  argocd_config = {
    hostname            = var.hostname
    redis_ha_enabled    = var.redis_ha_enable
    autoscaling_enabled = var.autoscaling_enabled
    ingress_class_name  = var.ingress_class_name
  }
}