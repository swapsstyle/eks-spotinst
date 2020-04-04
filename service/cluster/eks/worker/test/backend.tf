terraform {
  required_version = ">= 0.12.6"

  backend "s3" {
    bucket  = "<terraform-backend-bucket>"
    key     = "eks-spotinst/service/cluster/eks/worker/test.tfstate"
    region  = "eu-central-1"
    encrypt = "true"

    dynamodb_table = "<terraform-backend-table>"
  }
}