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

# variable "az" {
#   description = "List of availability zones"
#   type = map(object({
#     az-1a = 1,
#     az-1b = 2
#   }))
# }

variable "subnet_cidr" {
  description = "cidr block of subnet"
  type = map(number)
  default = {
    eu-west-1a = 0,
    eu-west-1b = 1
  }
}