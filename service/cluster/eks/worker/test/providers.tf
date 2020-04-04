terraform {
  required_version = ">= 0.11.8"
}

provider "aws" {
  version = ">= 1.47.0"
  region  = var.region
}


provider "spotinst" {
   token   = var.spotinst_token
   account = var.spotinst_account
}