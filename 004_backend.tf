terraform {
  backend "s3" {
    bucket = "jeffrey-tf-state"
    key    = "jeff/terraform.tfstate"
    # key    = "jeff/dev/terraform.tfstate"
    # key    = "jeff/prod/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
  }
}

