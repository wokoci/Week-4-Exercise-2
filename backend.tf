terraform {
  backend "s3" {
    bucket = "jeffrey-tf-state"
    key    = "jeff/terraform.tfstate"
    region = "eu-west-1"
    # profile = "value"
    dynamodb_table = "terraform-state-lock"
  }
}

