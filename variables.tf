variable "region" {
  description = "AWS region"
  type = string
  default = "eu-west-1"
}

variable "vpc_cidr" {
  description = "cidr block of vpc"
  default = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project"
  default = "platform-academy" 
}

variable "environment" {
  description = "Environment of the project"
  type = string
  default = "dev"
}