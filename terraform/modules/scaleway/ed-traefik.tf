
resource "helm_release" "traefik-ingress" {
  name      = "traefik-ingress"
  namespace = "kube-system"
  depends_on = [scaleway_k8s_pool.k8s-database-pool] 
  repository = "https://traefik.github.io/charts"
  chart = "traefik"
  timeout = 600
  values = [
    file("${path.module}/traefik/values.yaml")
  ]
}

resource "time_sleep" "attente-ip" {
  depends_on = [helm_release.traefik-ingress]
  create_duration = "30s"
}
