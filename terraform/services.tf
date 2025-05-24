
resource "kubectl_manifest" "service-postgres" {
  depends_on = [module.k8s, kubernetes_namespace.pgadmin]
  yaml_body= <<YAML
kind: Service
apiVersion: v1
metadata:
  name: postgres
  namespace: pgadmin
spec:
  type: ExternalName
  externalName: postgres-cluster-r.cnpg-database.svc.cluster.local
  ports:
  - port: 5432

YAML
}

resource "kubectl_manifest" "service-postgres-rw" {
  depends_on = [module.k8s, kubernetes_namespace.pgadmin]
  yaml_body= <<YAML
kind: Service
apiVersion: v1
metadata:
  name: postgres-master
  namespace: pgadmin
spec:
  type: ExternalName
  externalName: postgres-cluster-rw.cnpg-database.svc.cluster.local
  ports:
  - port: 5432

YAML
}

resource "kubectl_manifest" "service-postgres-rw-prof" {
  depends_on = [module.k8s, kubernetes_namespace.pgadmin]
  yaml_body= <<YAML
kind: Service
apiVersion: v1
metadata:
  name: postgres-prof
  namespace: pgadmin
spec:
  type: ExternalName
  externalName: postgres-cluster-rw.cnpg-database.svc.cluster.local
  ports:
  - port: 5432

YAML
}

resource "kubernetes_service" "service-ttyd" {
  metadata {
    name      = "service-ttyd"
    namespace = kubernetes_namespace.ttyd.metadata[0].name
  }

  spec {
    selector = {
      app = "ttyd"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP" # Type de service : ClusterIP, NodePort ou LoadBalancer
  }
}
