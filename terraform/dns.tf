resource "digitalocean_record" "dns_traefik_dashboard" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "traefik"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

resource "digitalocean_record" "dns_grafana" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "grafana"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

#resource "digitalocean_record" "dns_pgadmin" {
#  depends_on = [module.k8s]
#  domain = var.dns_domain
#  type   = "A"
#  name   = "pgadmin"
#  value  = module.k8s.lb_ip_address
#  ttl    = 300
#}

resource "digitalocean_record" "dns_pgadmin_1" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "pgadmin-1"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

resource "digitalocean_record" "dns_pgadmin_2" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "pgadmin-2"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

resource "digitalocean_record" "dns_pgadmin_3" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "pgadmin-3"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

resource "digitalocean_record" "dns_pgadmin_prof" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "pgadmin-prof"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

# resource "digitalocean_record" "dns_argocd" {
#   depends_on = [module.k8s]
#   domain = var.dns_domain
#   type   = "A"
#   name   = "argocd"
#   value  = module.k8s.lb_ip_address
#   ttl    = 300
# }

# resource "digitalocean_record" "dns_argo_workflows" {
#   depends_on = [module.k8s]
#   domain = var.dns_domain
#   type   = "A"
#   name   = "argo-workflows"
#   value  = module.k8s.lb_ip_address
#   ttl    = 300
# }

resource "digitalocean_record" "dns_phpldapadmin" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "phpldapadmin"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}

resource "digitalocean_record" "dns_cli" {
  depends_on = [module.k8s]
  domain = var.dns_domain
  type   = "A"
  name   = "cli"
  value  = module.k8s.lb_ip_address
  ttl    = 300
}