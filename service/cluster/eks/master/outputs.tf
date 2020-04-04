output "eks_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority
}

output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}