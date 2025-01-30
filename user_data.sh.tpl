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

# Create dbinfo.inc using cat
cat > /var/www/inc/dbinfo.inc << 'EOL'
<?php
define("DB_SERVER", "${db_endpoint}");
define("DB_USERNAME", "admin");
define("DB_PASSWORD", "password123");
define("DB_DATABASE", "sample");
?>
EOL

cd /var/www/html
git clone https://github.com/wokoci/hostWebApp.git
cp hostWebApp/* .
rm -rf hostWebApp

# Set proper ownership and permissions for the database info file
sudo chown ec2-user:apache /var/www/inc/dbinfo.inc
sudo chmod 0640 /var/www/inc/dbinfo.inc
