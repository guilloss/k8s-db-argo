terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
  }
}

# Récupération de la dernière version de k8s
data "scaleway_k8s_version" "latest" {
  name = "latest"
}

# Création d'un VPC pour le projet
resource "scaleway_vpc" "vpc-k8s-database" {
    name = var.k8s_vpc_name
}

# Création d'un PVN pour le projet
resource "scaleway_vpc_private_network" "pvn-k8s-database" {
    name = var.k8s_pvn_name
    vpc_id = scaleway_vpc.vpc-k8s-database.id
}

# Création du cluster K8S
resource "scaleway_k8s_cluster" "k8s-database-cluster" {
  name    = var.k8s_cluster_name
  version = data.scaleway_k8s_version.latest.name
  cni     = "cilium"
  private_network_id = scaleway_vpc_private_network.pvn-k8s-database.id
  delete_additional_resources = false
}

# Ajout d'un pool simple
resource "scaleway_k8s_pool" "k8s-database-pool" {
  cluster_id = scaleway_k8s_cluster.k8s-database-cluster.id
  name       = "${var.k8s_cluster_name}-pool-init"
  node_type  = var.k8s_scw_node_type
  size       = 4
}

# Ecriture en local du kubeconfig
resource "local_file" "fic_kubeconfig" {
  depends_on = [scaleway_k8s_pool.k8s-database-pool] 
  filename = "kubeconfig"
  content  = scaleway_k8s_cluster.k8s-database-cluster.kubeconfig[0].config_file
}

data "scaleway_lbs" "cluster_lb" {
    depends_on = [time_sleep.attente-ip,helm_release.traefik-ingress]
    tags = ["kapsule"]
}

output "lb_ip_address" {
  depends_on = [data.scaleway_lbs.cluster_lb,time_sleep.attente-ip,helm_release.traefik-ingress]
  description = "Adresse IP du load balancer"
  value = data.scaleway_lbs.cluster_lb.lbs[0].ips[0].ip_address
}

output "kubeconfig" {
  description = "éléments de configuration de Kube"
  value = {
    host                   = scaleway_k8s_cluster.k8s-database-cluster.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.k8s-database-cluster.kubeconfig[0].token
    cluster_ca_certificate = scaleway_k8s_cluster.k8s-database-cluster.kubeconfig[0].cluster_ca_certificate
  }
}
