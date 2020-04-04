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

variable "whitelist_ips" {
  default = [
  ]
}

variable "eks_cluster_name" {
  description = "cluster_id is a unique name for the cluster."
  default     = "my-eks-cluster"
}

locals {
  common_tags = map(
  "Project", "eks-spotinst",
  "Region", var.region,
  "Environment", var.environment,
  "Group", "eks-security-group",
  "Credits", "swapsstyle"
  )
}
