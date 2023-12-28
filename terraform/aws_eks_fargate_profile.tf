resource "aws_eks_fargate_profile" "staging" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "staging"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  # These subnets must have the following resource tag:
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = data.aws_subnet_ids.public-vpc-private-subnet-all.ids

  selector {
    namespace = "staging"
  }
}