resource "helm_release" "loki-distributed" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "aws-observability"
  chart      = "loki-distributed"
  version    = "0.69.16"
  values = [
    templatefile("${path.module}/loki.yaml", {})
  ]
}
resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "aws-observability"
  chart      = "promtail"
  version    = "6.11.3"
  set {
    name  = "promtail.enabled"
    value = "true"
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  values = [
    templatefile("${path.module}/promtail-values.yaml", {})
  ]

}

locals {
  ingress_manifest = yamldecode(file("${path.module}/ingress.yaml"))
}

resource "kubernetes_manifest" "ingress" {
  manifest = local.ingress_manifest
}
