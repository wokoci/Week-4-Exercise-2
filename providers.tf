provider "aws" {
  region     = "eu-west-1"
#   access_key = "AWS_ACCESS_KEY_ID"
#   secret_key = "AWS_SECRET_ACCESS_KEY"
    shared_credentials_files = ["~/.aws/credentials"]


}

