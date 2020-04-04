output "eks_master_node" {
  value = aws_iam_role.eks_master_node.arn
}

output "eks_worker_node" {
  value = aws_iam_role.eks_worker_node.arn
}

output "eks_worker_node_instance_profile_name" {
  value = aws_iam_instance_profile.eks_worker_node.name
}