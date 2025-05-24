variable "k8s_version" {
    type = string
    default = "latest"
}

variable "k8s_cluster_name" {
    type = string
    default = "k8s-db"
}

variable "k8s_vpc_name" {
    type = string
    default = "vpc-k8s-db"
}

variable "k8s_pvn_name" {
    type = string
    default = "pvn-k8s-db"
}
variable "k8s_scw_node_type" {
    type = string
    default = "DEV1-M"
}
variable "scw_region" {
    type = string
    default = "fr-par"
}
variable "scw_zone" {
    type = string
    default = "fr-par-1"
}
variable "k8s_pool_size" {
    type = string
    default = "1"
}