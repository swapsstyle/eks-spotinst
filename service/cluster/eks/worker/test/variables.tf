variable "region" {
  default = "eu-central-1"
}

variable "environment" {
  default = "test"
}

variable "worker_ssh_key" {
  default = ""
}

variable "spotinst_token" {
  default = ""
}

variable "spotinst_account" {
  default = ""
}

variable "eks_cluster_name" {
  default = "my-eks-cluster"
}


locals {
  common_tags = map(
  "Name", var.eks_cluster_name,
  "Project", "eks-spotinst",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "eks-cluster-test-group",
  "Nodegroup", "test",
  "Credits", "swapsstyle"
  )
}
