terraform {
  backend "s3" {
    bucket = "<terraform-backend-bucket>"
    key    = "eks-spotinst/networking/vpc/vpc.tfstate"
    region = "eu-central-1"
    encrypt = "true"
    dynamodb_table = "<terraform-backend-table>"
  }
}
