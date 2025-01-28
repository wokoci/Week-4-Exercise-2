
# Create a VPC
resource "aws_vpc" "jeff_Tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "${var.project_name}-jeff-vpc"
  }
}

# add data source get all availability zones in region
data "aws_availability_zones" "available" { state = "available" }

# create subnet in az1 public
resource "aws_subnet" "jeff_Tf_subnet" {
  vpc_id                  = aws_vpc.jeff_Tf_vpc.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1a]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet1"
  }
}

# create subnet in az2 public
resource "aws_subnet" "jeff_Tf_subnet2" {
  vpc_id                  = aws_vpc.jeff_Tf_vpc.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1b]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet2"
  }
}

# create subnet in az3 private
resource "aws_subnet" "jeff_Tf_subnet3" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = var.subnet3_cidr
  availability_zone = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1a]
  tags = {
    Name = "${var.project_name}-subnet3"
  }
}

# create subnet in az4 private
resource "aws_subnet" "jeff_Tf_subnet4" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = var.subnet4_cidr
  availability_zone = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1b]
  tags = {
    Name = "${var.project_name}-subnet4"
  }
}


# create subnet in az5 private
resource "aws_subnet" "jeff_Tf_subnet5" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = var.subnet5_cidr
  availability_zone = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1a]
  tags = {
    Name = "${var.project_name}-subnet5"
  }
}

# create subnet in az6 private
resource "aws_subnet" "jeff_Tf_subnet6" {
  vpc_id            = aws_vpc.jeff_Tf_vpc.id
  cidr_block        = var.subnet6_cidr
  availability_zone = data.aws_availability_zones.available.names[var.subnet_cidr.eu-west-1b]
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
    Name = "${var.project_name}-jeff_Tf"
  }
}

# create route table for public subnets 
resource "aws_route_table_association" "jeff_Tf_RT_association_subnet1" {
  subnet_id      = aws_subnet.jeff_Tf_subnet.id
  route_table_id = aws_route_table.jeff_Tf_RT.id

}
# create route table for public subnets 2
resource "aws_route_table_association" "jeff_Tf_RT_association_subnet2" {
  subnet_id      = aws_subnet.jeff_Tf_subnet2.id
  route_table_id = aws_route_table.jeff_Tf_RT.id

}

