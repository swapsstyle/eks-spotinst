
resource "aws_route_table" "eks_public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS Public Route Table"
    )
  )
}

resource "aws_route" "eks_public_route" {
  route_table_id         = aws_route_table.eks_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_vpc_gw.id
}

resource "aws_route_table_association" "eks_public_rta" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.eks_public_sn.*.id[count.index]
  route_table_id = aws_route_table.eks_public_rt.id
}

resource "aws_route_table" "eks_private_rt" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.common_tags,
    map(
      "Name", "EKS Private Route Table - ${element(var.availability_zones, count.index)}"
    )
  )
}

resource "aws_route" "eks_private_route" {
  count = length(var.availability_zones)

  route_table_id         = aws_route_table.eks_private_rt.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eks_nat_gateway.*.id[count.index]
}

resource "aws_route_table_association" "eks_private_rta" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.eks_private_sn.*.id[count.index]
  route_table_id = aws_route_table.eks_private_rt.*.id[count.index]
}
