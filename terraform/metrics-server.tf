provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.this.id]
      command     = "aws"
    }
  }
}

resource "helm_release" "metrics-server" {
  count =0
  name = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.8.2"
  recreate_pods =true
  force_update =true
  values = [
    file("${path.module}/metrics-server-values.yaml")
  ]
  depends_on = [aws_eks_fargate_profile.kube-system]
}