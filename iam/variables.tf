variable "environment" {
  default = "global"
}

variable "region" {
  default = "eu-central-1"
}

locals {
  common_tags = map(
  "Project", "eks-spotinst",
  "Region", "global",
  "Environment", var.environment,
  "Group", "eks-iam",
  "Credits", "swapsstyle"
  )
}
