locals {
  name = "kafka-ui"

  default_helm_config = {
    name             = local.name
    description      = "Versatile, fast and lightweight web UI for managing Apache Kafka® clusters. Built by developers, for developers."
    chart            = local.name
    repository       = "https://provectus.github.io/kafka-ui"
    version          = "0.4.0"
    namespace        = local.name
    create_namespace = true
    force_update     = false
    recreate_pods    = false
    values           = local.default_helm_values
    timeout          = 1200
  }

  default_helm_values = [
    templatefile("${path.module}/values.yaml", {
      appConfig = var.app_config
      envConfig = var.env_config
    })
  ]

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}