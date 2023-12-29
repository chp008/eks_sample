resource "helm_release" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.4.1"

  force_update =true

  set {
    name  = "clusterName"
    value = aws_eks_cluster.this.id
  }

  set {
    name  = "image.tag"
    value = "v2.6.2"
  }

  set {
    name  = "image.repository"
    value = "188424177863.dkr.ecr.cn-northwest-1.amazonaws.com.cn/aws-load-balancer-controller"
  }

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }

  # EKS Fargate specific
  set {
    name  = "region"
    value = "cn-northwest-1"
  }

  set {
    name  = "vpcId"
    value = data.aws_vpc.public-vpc.id
  }

  depends_on = [aws_eks_fargate_profile.kube-system]
}