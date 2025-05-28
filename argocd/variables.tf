variable "helm_repo_url" {
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
  description = "Helm repository"
}

variable "argocd_namespace" {
  description = "Namespace to release argocd into"
  type        = string
  default     = "argocd"
}

variable "argocd_helm_chart_version" {
  description = "argocd helm chart version to use"
  type        = string
  default     = ""
}

variable "argocd_server_host" {
  description = "Hostname for argocd (will be utilised in ingress if enabled)"
  type        = string
  default     = "argocd-ovh.neuronsw.com"
}

variable "argocd_ingress_class" {
  description = "Ingress class to use for argocd"
  type        = string
  default     = "nginx"
}

variable "argocd_ingress_enabled" {
  description = "Enable/disable argocd ingress"
  type        = bool
  default     = true
}

variable "argocd_ingress_tls_acme_enabled" {
  description = "Enable/disable acme TLS for ingress"
  type        = string
  default     = "true"
}

variable "argocd_ingress_ssl_passthrough_enabled" {
  description = "Enable/disable SSL passthrough for ingresss"
  type        = string
  default     = "true"
}

variable "argocd_ingress_tls_secret_name" {
  description = "Secret name for argocd TLS cert"
  type        = string
  default     = "argocd-cert"
}

variable "argocd_name" {
  default = "argocd"
}

variable "argocd_config" {
  type = any
  default = {
    hostname            = ""
    redis_ha_enabled    = false
    autoscaling_enabled = false
    ingress_class_name  = ""
  }
  description = "Specify the configuration settings for Argocd, including the hostname, redis_ha_enabled, autoscaling, notification settings, and custom YAML values."
}

variable "chart_version" {
  type        = string
  default     = "7.3.11"
  description = "Version of the Argocd chart that will be used to deploy Argocd application."
}

variable "namespace" {
  type        = string
  default     = "argocd"
  description = "Name of the Kubernetes namespace where the Argocd deployment will be deployed."
}

variable "ingress_class_name" {
  type        = string
  default     = "nginx"
  description = "Enter ingress class name which is created in EKS cluster"
}

variable "issuer_name" {
  type        = string
  description = "Cluster Issuer Name."
}
