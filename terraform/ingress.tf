resource "kubectl_manifest" "ingress-dashboard-traefik" {
  depends_on = [module.k8s]
  yaml_body= <<YAML
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-dashboard
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(`traefik.${var.dns_domain}`)
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
  tls:
      certResolver: letsencrypt
YAML
}

resource "kubectl_manifest" "ingress-grafana" {
  depends_on = [module.k8s]
  yaml_body= <<YAML
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-grafana
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(`grafana.${var.dns_domain}`)
      kind: Rule
      services:
        - name: prometheus-grafana
          port: 80
  tls:
      certResolver: letsencrypt
YAML
}

resource "kubectl_manifest" "ingress-argocd" {
  depends_on = [module.k8s]
  yaml_body= <<YAML
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-argocd
  namespace: ${kubernetes_namespace.argocd.metadata[0].name}
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(`argocd.${var.dns_domain}`)
      kind: Rule
      services:
        - name: argocd-server
          port: 80
  tls:
      certResolver: letsencrypt
YAML
}


resource "kubectl_manifest" "ingress-argo-workflows" {
  depends_on = [module.k8s]
  yaml_body= <<YAML
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-argo-workflows
  namespace: ${kubernetes_namespace.argocd.metadata[0].name}
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(`argo-workflows.${var.dns_domain}`)
      kind: Rule
      services:
        - name: argo-workflows-server
          port: 2746
  tls:
      certResolver: letsencrypt
YAML
}
