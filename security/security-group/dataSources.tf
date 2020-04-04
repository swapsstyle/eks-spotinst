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
