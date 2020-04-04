resource "aws_security_group" "eks_internal_sg" {
  name = "eks_internal_sg"
  description = "EKS Internal, Default security group that allows all instances in the Cluster to talk to each other over any port and protocol."

  vpc_id = data.terraform_remote_state.eks_vpc.outputs.eks_vpc_id

  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      data.terraform_remote_state.eks_vpc.outputs.eks_vpc_cidr_block]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "EKS Internal Cluster SG",
  "kubernetes.io/cluster/${var.eks_cluster_name}", "owned"
  )
  )
}

resource "aws_security_group" "eks_master_sg" {
  name = "eks_master_sg"
  description = "EKS Master, allow access to EKS master"

  vpc_id = data.terraform_remote_state.eks_vpc.outputs.eks_vpc_id

  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = var.whitelist_ips
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "EKS Master SG",
  "kubernetes.io/cluster/${var.eks_cluster_name}", "owned"
  )
  )
}

resource "aws_security_group" "eks_public_ingress_sg" {
  name = "eks_public_ingress_sg"
  description = "EKS VPC, PUBLIC INGRESS, Security group that allows public ingress to instances, HTTP, HTTPS and more."

  vpc_id = data.terraform_remote_state.eks_vpc.outputs.eks_vpc_id

  //  HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    self = true
    cidr_blocks = var.whitelist_ips

  //  HTTP Proxy
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    self = true
    cidr_blocks = var.whitelist_ips

  //  HTTPS
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    self = true
    cidr_blocks = var.whitelist_ips

  //  HTTPS Proxy
  ingress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    self = true
    cidr_blocks = var.whitelist_ips

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = merge(
  local.common_tags,
  map(
  "Name", "EKS Public Ingress SG",
  "kubernetes.io/cluster/${var.eks_cluster_name}", "owned"
  )
  )
}
