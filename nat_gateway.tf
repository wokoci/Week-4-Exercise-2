resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "jeff-public_ip_for_nat_gateway"
  }
}

resource "aws_nat_gateway" "aws_nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.jeff_load_balancer_subnet1.id
  tags = {
    Name = "aws_nat_gateway_Az1"
  }
  depends_on = [aws_internet_gateway.jeff_Tf_IGW]
}


resource "aws_route_table" "private_route_Table" {
  vpc_id = aws_vpc.jeff_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway.id
  }

  tags = {
    name = "private nat gateway"
  }
}


# link private route table to nat gateway
resource "aws_route_table_association" "jeff_Tf_RT_association_subnet3" {
  subnet_id      = aws_subnet.jeff_Tf_subnet3.id
  route_table_id = aws_route_table.private_route_Table.id
  # not sure of the above
}

resource "aws_route_table_association" "subnet4_RT_association" {
  subnet_id      = aws_subnet.jeff_Tf_subnet4.id
  route_table_id = aws_route_table.private_route_Table.id
}

resource "aws_route_table_association" "subnet5_RT_association" {
  subnet_id      = aws_subnet.jeff_Tf_subnet5.id
  route_table_id = aws_route_table.private_route_Table.id
}

resource "aws_route_table_association" "subnet6_associations" {
  subnet_id = aws_subnet.jeff_Tf_subnet6.id
  route_table_id = aws_route_table.private_route_Table.id
}
