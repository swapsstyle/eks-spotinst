resource "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
  role_arn = data.terraform_remote_state.eks_iam.outputs.eks_master_node

  vpc_config {
    security_group_ids = [
      data.terraform_remote_state.eks_security_group.outputs.eks_internal_sg, data.terraform_remote_state.eks_security_group.outputs.eks_master_sg
    ]
    subnet_ids = data.terraform_remote_state.eks_vpc.outputs.eks_private_sn_id_list
  }

  tags = merge(
    local.common_tags,
  )
}

