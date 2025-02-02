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
  profile                  = "default"
  shared_credentials_files = ["~/.aws/credentials"]
}
