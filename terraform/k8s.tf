# Appel du module permettant de créer le cluster K8S.
module "k8s" {
  source = "./modules/scaleway"
  k8s_vpc_name = var.k8s_vpc_name
  k8s_pvn_name = var.k8s_pvn_name
  k8s_cluster_name = var.k8s_cluster_name
  k8s_scw_node_type = var.k8s_scw_node_type
  scw_region = var.scw_region
  scw_zone = var.scw_zone
}

