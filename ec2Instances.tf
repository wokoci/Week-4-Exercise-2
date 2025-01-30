resource "aws_key_pair" "jeff_key_pair" {
  key_name   = "jeff-key"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "jeff-key"
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
    Name = "jeff-jumpbox_Instance"
  }
}

# data "aws_db_instance" "database" {
#   db_instance_identifier = "jeff-mysql-db"
# }

# data.aws_db_instance.database.address

resource "aws_instance" "private_ec2_instance1" {
  ami             = "ami-0720a3ca2735bf2fa"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.jeff_key_pair.key_name
  tenancy         = "default"
  subnet_id       = aws_subnet.jeff_ec2_subnet4.id
  security_groups = [aws_security_group.private_appServer_SG.id]

  #add user data to install nginx for amazon linux 2023
    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install git -y
              sudo dnf install -y httpd php php-mysqli mariadb105
              sudo systemctl start httpd 
              sudo systemctl enable httpd
              
              # Configure Apache and permissions
              sudo usermod -a -G apache ec2-user
              sudo chown -R ec2-user:apache /var/www
              sudo chmod 2775 /var/www
              find /var/www -type d -exec sudo chmod 2775 {} \;
              find /var/www -type f -exec sudo chmod 0664 {} \;
              
              # Create and configure database connection file
              sudo mkdir -p /var/www/inc
              sudo chown ec2-user:apache /var/www/inc
              
              chown ec2-user:apache /var/www/inc
  
            # Create dbinfo.inc using printf
              printf '<?php\ndefine(\"DB_SERVER\", \"${aws_db_instance.mysql_instance.address}\");\ndefine(\"DB_USERNAME\", \"admin\");\ndefine(\"DB_PASSWORD\", \"password123\");\ndefine(\"DB_DATABASE\", \"sample\");\n?>' > /var/www/inc/dbinfo.inc

              cd /var/www/html
              git clone https://github.com/wokoci/hostWebApp.git
              cp hostWebApp/* .
              rm -rf hostWebApp

              # Set proper ownership and permissions for the database info file
              sudo chown ec2-user:apache /var/www/inc/dbinfo.inc
              sudo chmod 0640 /var/www/inc/dbinfo.inc
              EOF
  tags = {
    Name = "jeff-private_ec2_tf_Instance_1"
  }

}

resource "aws_instance" "private_ec2_instance2" {
  ami             = "ami-0720a3ca2735bf2fa"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.jeff_key_pair.key_name
  tenancy         = "default"
  subnet_id       = aws_subnet.jeff_DB_subnet5.id
  security_groups = [aws_security_group.private_appServer_SG.id]

  #add user data to install nginx for amazon linux 2023
 user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install git -y
              sudo dnf install -y httpd php php-mysqli mariadb105
              sudo systemctl start httpd 
              sudo systemctl enable httpd
              
              # Configure Apache and permissions
              sudo usermod -a -G apache ec2-user
              sudo chown -R ec2-user:apache /var/www
              sudo chmod 2775 /var/www
              find /var/www -type d -exec sudo chmod 2775 {} \;
              find /var/www -type f -exec sudo chmod 0664 {} \;
              
              # Create and configure database connection file
              sudo mkdir -p /var/www/inc
              sudo chown ec2-user:apache /var/www/inc
              
              chown ec2-user:apache /var/www/inc
  
            # Create dbinfo.inc using printf
              printf '<?php\ndefine(\"DB_SERVER\", \"${aws_db_instance.mysql_instance.address}\");\ndefine(\"DB_USERNAME\", \"admin\");\ndefine(\"DB_PASSWORD\", \"password123\");\ndefine(\"DB_DATABASE\", \"sample\");\n?>' > /var/www/inc/dbinfo.inc

              cd /var/www/html
              git clone https://github.com/wokoci/hostWebApp.git
              cp hostWebApp/* .
              rm -rf hostWebApp

              # Set proper ownership and permissions for the database info file
              sudo chown ec2-user:apache /var/www/inc/dbinfo.inc
              sudo chmod 0640 /var/www/inc/dbinfo.inc
              EOF

  tags = {
    Name = "jeff-private_ec2_tf_Instance_2"
  }

}


output "Jumpbox_public_ec2_instance1" {
  description = "public IP of ec2 instance Jumpbox"
  value       = aws_instance.Jumpbox_ec2_instance.public_ip
}

# output "private_dns_ec2_instance2" {
#   description = "private IP of ec2 instance 2"
#   value       = aws_instance.private_ec2_instance2.private_ip
# }
