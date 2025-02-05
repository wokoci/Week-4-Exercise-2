resource "aws_security_group" "public_LB_SG" {
  vpc_id      = aws_vpc.jeff_vpc.id
  name        = "${var.project_name}-${var.environment}-jf_alb-sg"
  description = "enable http and https traffic on port 443/80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all inbound HTTP traffic on port 80"

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all inbound HTTP traffic on port 443"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-jf_alb-sg"
  }

}

resource "aws_security_group" "jump_box_SG" {
  vpc_id = aws_vpc.jeff_vpc.id
  name   = "${var.project_name}-${var.environment}-jumpBox"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow inbound SSH traffic into jumpbox"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-jumpBox"
  }
}


resource "aws_security_group" "private_appServer_SG" {
  vpc_id      = aws_vpc.jeff_vpc.id
  name        = "${var.project_name}-${var.environment}-private_ec2_SG"
  description = "allow traffic if its coming from the load balancer Security group on port 80/443"


  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_LB_SG.id]
    description     = "allow inbound HTTP"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_LB_SG.id]
    description     = "allow inbound HTTPS"
  }


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_box_SG.id]
    description     = "allow inbound SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-appServer-SG"
  }

}


resource "aws_security_group" "RDS_public_sg" {
  name        = "${var.project_name}-${var.environment}-port 3306"
  description = "public security group for public instances"
  vpc_id      = aws_vpc.jeff_vpc.id



 ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.private_appServer_SG.id  ]
    description = "allow inbound 443 traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jump_box_SG.id]
    description = "allow inbound SSH from app server SG"
  }
 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-RDS_subnet_SG"
  }

}
