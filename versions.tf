terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "tfstate-androvnyi"
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
  }
}
