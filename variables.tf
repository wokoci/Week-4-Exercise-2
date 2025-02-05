variable "region" {
  description = "AWS region"
  type        = string
  # default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "cidr block of vpc"
  # default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project"
  # default     = "platform-academy"
}

variable "environment" {
  description = "Environment of the project"
  type        = string
  # default     = "dev"
}

variable "subnet_cidr" {
  description = "cidr block of subnet"
  type        = map(number)
  default = {
    eu-west-1a = 0,
    eu-west-1b = 1
  }
}

variable "management_subnet_cidr" {
  description = "cidr block of management subnet"
  type        = string
  # default     = "10.0.0.0/24" 
}


variable "subnet1_cidr" {
  description = "cidr block of subnet1"
  type        = string
  # default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  description = "cidr block of subnet1"
  type        = string
  # default     = "10.0.2.0/24"
}

variable "subnet3_cidr" {
  description = "cidr block of subnet1"
  type        = string
  # default     = "10.0.3.0/24"
}

variable "subnet4_cidr" {
  description = "cidr block of subnet1"
  type        = string
  # default     = "10.0.4.0/24"
}

variable "subnet5_cidr" {
  description = "cidr block of subnet1"
  type        = string
  # default     = "10.0.5.0/24"
}

variable "subnet6_cidr" {
  description = "cidr block of subnet1"
  type        = string
  default     = "10.0.6.0/24"
}

variable "ec2_instance_type" {
  description = "Type of ec2 instance"
  type        = string
  # default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI id"
  type        = string
  # default     = "ami-0c55b159cbfafe1f0"
}

variable "acm_domain_name" {
  description = "domain name of site"
  type        = string
  # default     = "jeff.aws.lab.bancey.xyz"
}

variable "acm_root_domain" {
  description = "root domain name"
  type = string
  # default     = "aws.lab.bancey.xyz"
}

variable "key_pair" {
  description = "key pair for ssh connection"
  type = string
}

variable "target_group" {
  description = "target group "
  type = string
}

variable "app_load_balancer" {
  description = "application load balancer"
  type = string
}