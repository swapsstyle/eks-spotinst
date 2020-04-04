variable "environment" {
  default = "test"
}

variable "region" {
  default = "eu-central-1"
}

variable "availability_zones" {
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}

variable "eks_cluster_name" {
  default = "my-eks-cluster"
}

locals {
  common_tags = map(
  "Name", var.eks_cluster_name,
  "Project", "test",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "eks-cluster",
  "Credits", "swapsstyle"
  )
}
