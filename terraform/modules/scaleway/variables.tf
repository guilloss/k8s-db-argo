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