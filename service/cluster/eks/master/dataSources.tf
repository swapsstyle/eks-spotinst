# Remote state VPC
data "terraform_remote_state" "eks_vpc" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<terraform-backend-bucket>"
    key = "eks-spotinst/networking/vpc/vpc.tfstate"
    region = var.region
  }
}

# Remote state IAM
data "terraform_remote_state" "eks_iam" {
  backend = "s3"

  config = {
    bucket = "<terraform-backend-bucket>"
    key = "eks-spotinst/iam/iam.tfstate"
    region = var.region
  }
}

# Remote state Security Group
data "terraform_remote_state" "eks_security_group" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = "<terraform-backend-bucket>"
    key = "eks-spotinst/security/security-group/security-group.tfstate"
    region = var.region
  }
}
