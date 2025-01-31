output "Jumpbox_public_ec2_instance1" {
  description = "public IP of ec2 instance Jumpbox"
  value       = aws_instance.Jumpbox_ec2_instance.public_ip
}


output "rds_server" {
  description = "rds database server url"
  value = aws_db_instance.mysql_instance.address
}

output "site_url" {
  value = "https://jeff.aws.lab.bancey.xyz"
}
