terraform {
  backend "s3" {
    bucket         = "tfstate-androvnyi"
    key            = "envs/dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
