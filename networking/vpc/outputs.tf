output "eks_vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "eks_vpc_cidr_block" {
  value = aws_vpc.eks_vpc.cidr_block
}

output "eks_public_sn_id_list" {
  value = aws_subnet.eks_public_sn.*.id
}

output "eks_public_sn_cidr_block" {
  value = aws_subnet.eks_public_sn.*.cidr_block
}

output "eks_private_sn_id_list" {
  value = aws_subnet.eks_private_sn.*.id
}

output "eks_private_sn_cidr_block" {
  value = aws_subnet.eks_private_sn.*.cidr_block
}

output "eks_nat_eip_id_list" {
  value = aws_eip.eks_nat_eip.*.id
}
