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

variable "cidr_block" {
  description = "VPC cidr block. Example: 10.1.0.0/16"
  default = "10.2.0.0/16"
}

variable "eks_cluster_name" {
  default = "my-eks-cluster"
}

locals {
  common_tags = map(
  "Project", "eks-spotinst",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "eks-vpc",
  "Credits", "swapsstyle"
  )
}
