terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "eu-west-1"
  profile                  = "AWSAdministratorAccess-841162714039"
  shared_credentials_files = ["~/.aws/credentials"]
}
