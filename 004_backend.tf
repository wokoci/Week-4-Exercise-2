terraform {
  backend "s3" {
    bucket = "jeffrey-tf-state"
    # key    = "jeff/terraform.tfstate"
    # key    = "dev/terraform.tfstate"
    key    = "prod/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}

