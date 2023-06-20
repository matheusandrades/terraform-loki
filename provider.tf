provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Altere o caminho do arquivo de configuração do Kubernetes se necessário
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Caminho para o arquivo de configuração do Kubernetes

  // Outras configurações do provedor, se necessário
}
