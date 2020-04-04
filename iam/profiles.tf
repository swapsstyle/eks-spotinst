resource "aws_iam_instance_profile" "eks_worker_node" {
  name = "eks_worker_node_profile"
  role = aws_iam_role.eks_worker_node.name
}