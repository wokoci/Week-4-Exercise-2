
# Create a VPC
resource "aws_vpc" "jeff_Tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy = "default"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# create subnet in az1 public
resource "aws_subnet" "jeff_Tf_subnet" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.project_name}-subnet1"
  }
}

# create subnet in az2 public
resource "aws_subnet" "jeff_Tf_subnet2" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = "${var.project_name}-subnet2"
  }
}

# create subnet in az3 private
resource "aws_subnet" "jeff_Tf_subnet3" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.project_name}-subnet3"
  }
}

# create subnet in az4 private
resource "aws_subnet" "jeff_Tf_subnet4" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = "${var.project_name}-subnet4"
  }
}

# create subnet in az5 private
resource "aws_subnet" "jeff_Tf_subnet5" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.project_name}-subnet5"
  }
}

# create subnet in az6 private
resource "aws_subnet" "jeff_Tf_subnet6" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = "${var.project_name}-subnet6"
  }
}

#add internet gateway
resource "aws_internet_gateway" "jeff_Tf_IGW" {
  vpc_id = aws_vpc.jeff_Tf_vpc.id

  tags = {
    Name = "${var.project_name}-jeff_Tf_gw"
  }
}

resource "aws_route_table" "jeff_Tf_RT" {
  vpc_id = aws_vpc.jeff_Tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jeff_Tf_IGW.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-jeff_Tf_route"
  }
}





 
