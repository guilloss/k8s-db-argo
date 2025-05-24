terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.17"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.3.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "s3" {}
}

provider "scaleway" {
  access_key = var.scw_access_key
  secret_key = var.scw_secret_key
  project_id = var.scw_project_id
  region = var.scw_region
  zone = var.scw_zone
}


provider "digitalocean" {
  token = var.digitalocean_token
}

provider "kubernetes"{
    host = module.k8s.kubeconfig.host
    token = module.k8s.kubeconfig.token
    cluster_ca_certificate = base64decode(module.k8s.kubeconfig.cluster_ca_certificate)
}

provider "kubectl"{
    host = module.k8s.kubeconfig.host
    token = module.k8s.kubeconfig.token
    cluster_ca_certificate = base64decode(module.k8s.kubeconfig.cluster_ca_certificate)
    load_config_file = false
}

provider "helm" {
  kubernetes {
    host = module.k8s.kubeconfig.host
    token = module.k8s.kubeconfig.token
    cluster_ca_certificate = base64decode(module.k8s.kubeconfig.cluster_ca_certificate)
  }
}

