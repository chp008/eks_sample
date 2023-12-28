data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = local.tfstate-aws-region
}

terraform {
  required_version = ">= 0.13.0"
  # Bucket which contains the terraform state.
  # Must have been created manually or by some kind of bootstrap job.
  backend "s3" {

  }
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "4.58.0"
    }
  }
}