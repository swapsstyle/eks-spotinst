output "eks_internal_sg" {
  value = aws_security_group.eks_internal_sg.id
}

output "eks_public_ingress_sg" {
  value = aws_security_group.eks_public_ingress_sg.id
}

output "eks_master_sg" {
  value = aws_security_group.eks_master_sg.id
}