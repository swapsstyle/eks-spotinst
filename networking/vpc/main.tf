
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS VPC",
      "kubernetes.io/cluster/${var.eks_cluster_name}", "shared"
    )
  )
}


resource "aws_internet_gateway" "eks_vpc_gw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS VPC IGW"
    )
  )
}
