resource "aws_key_pair" "jeff_key_pair" {
  key_name   = "jeff-key"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "jeff-key"
  }
}

resource "aws_instance" "public_ec2_instance1" {
  ami             = "ami-0720a3ca2735bf2fa"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.jeff_key_pair.key_name
  tenancy         = "default"
  subnet_id       = aws_subnet.jeff_Tf_subnet.id
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "jeff-public_ec2_tf_Instance_1"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_instance" "public_ec2_instance2" {
  ami             = "ami-0720a3ca2735bf2fa"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.jeff_key_pair.key_name
  tenancy         = "default"
  subnet_id       = aws_subnet.jeff_Tf_subnet2.id
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "jeff-public_ec2_tf_Instance_2"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}




output "public_dns_public_ec2_instance1" {
  description = "public dns of ec2 instance 1"
  value       = aws_instance.public_ec2_instance1.public_ip
}

output "public_dns_public_ec2_instance2" {
  description = "public dns of ec2 instance 2"
  value       = aws_instance.public_ec2_instance2.public_ip
}
