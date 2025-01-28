resource "aws_eip" "public_ip_for_nat_gateway" {
  domain = "vpc"
  tags = {
    Name = "jeff-public_ip_for_nat_gateway"
  }
}

resource "aws_nat_gateway" "aws_nat_gateway_Az1" {
  allocation_id = aws_eip.public_ip_for_nat_gateway.id
  subnet_id     = aws_subnet.jeff_Tf_subnet.id
  tags = {
    Name = "aws_nat_gateway_Az1"
  }
  depends_on = [aws_internet_gateway.jeff_Tf_IGW]

}