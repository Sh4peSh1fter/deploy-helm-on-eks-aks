# resource "helm_release" "hello_world" {
#   name       = "${var.name}-hello-world-${var.env}"
#   repository = "https://kubernetes.github.io/dashboard/" # "https://charts.bitnami.com/bitnami"
#   chart      = "kubernetes-dashboard"                    # "hello-kubernetes"
#   # version    = "8.0.1"
#   # values     = [file("${path.module}/values.yaml")]

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }

#   set {
#     name  = "protocolHttp"
#     value = "true"
#   }

#   set {
#     name  = "service.externalPort"
#     value = 80
#   }

#   set {
#     name  = "replicaCount"
#     value = 2
#   }

#   set {
#     name  = "rbac.clusterReadOnlyRole"
#     value = "true"
#   }
# }


resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = "default"
  # create_namespace = true
}
