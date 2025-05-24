resource "kubernetes_namespace" "argocd" {
  depends_on = [module.k8s]
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [module.k8s]
  name      = "argocd"
  namespace = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  values = [
    templatefile("../argocd/argocd-values.yaml.tpl", {
       argocd_admin_password = random_password.argocd_admin_password
    })
  ]
}

resource "helm_release" "argo-workflows" {
  depends_on = [module.k8s]
  name      = "argo-workflows"
  namespace = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-workflows"
  values = [
    file("../argo-workflows/argo-workflows-values.yaml") 
  ]
}