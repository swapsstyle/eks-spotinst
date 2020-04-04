terraform {
  backend "s3" {
    bucket = "<terraform-backend-bucket>"
    key    = "eks-spotinst/iam/iam.tfstate"
    region = "eu-central-1"
    encrypt = "true"
    dynamodb_table = "<terraform-backend-table>"
  }
}