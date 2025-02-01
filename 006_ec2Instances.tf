resource "aws_key_pair" "jeff_key_pair" {
  key_name   = "jeff-key"
  public_key = file("./key_material.txt")
  # public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "${var.project_name}-${var.environment}-jeff-key"
  }
}


resource "aws_instance" "Jumpbox_ec2_instance" {
  ami             = "ami-0720a3ca2735bf2fa"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.jeff_key_pair.key_name
  tenancy         = "default"
  subnet_id       = aws_subnet.jeff_Tf_mgmt_subnet.id
  security_groups = [aws_security_group.jump_box_SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.project_name}-${var.environment}-jeff-jumpbox_Instance"
  }
}

# data "aws_db_instance" "database" {
#   db_instance_identifier = "jeff-mysql-db"
# }

# data.aws_db_instance.database.address





# output "private_dns_ec2_instance2" {
#   description = "private IP of ec2 instance 2"
#   value       = aws_instance.private_ec2_instance2.private_ip
# }
