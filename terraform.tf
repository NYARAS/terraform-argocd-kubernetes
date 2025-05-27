terraform {
  required_version = ">= 0.15.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}
