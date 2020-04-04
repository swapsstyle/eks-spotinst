resource "aws_subnet" "eks_public_sn" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS Public subnet - ${element(var.availability_zones, count.index)}",
      "kubernetes.io/cluster/${var.eks_cluster_name}", "shared"
    )
  )
}

resource "aws_subnet" "eks_private_sn" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.eks_vpc.id

  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS Private subnet - ${element(var.availability_zones, count.index)}",
      "kubernetes.io/cluster/${var.eks_cluster_name}", "shared"
    )
  )
}

resource "aws_eip" "eks_nat_eip" {
  count = length(var.availability_zones)
  vpc = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS Elactic IP - ${element(var.availability_zones, count.index)}"
    )
  )
}

resource "aws_nat_gateway" "eks_nat_gateway" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.eks_public_sn.*.id[count.index]
  allocation_id = aws_eip.eks_nat_eip.*.id[count.index]

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS NAT Gateway - ${element(var.availability_zones, count.index)}"
    )
  )
}
