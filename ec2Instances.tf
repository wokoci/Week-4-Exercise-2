# instance category : Amazon Linux 2023 
# ami id  : 0720a3ca2735bf2fa
# instance type : t2.micro
# jeypair : 



# resource "aws_instance" "this" {
#   ami           = "ami-0720a3ca2735bf2fa"
#   instance_type = "t2.micro"
#   key_name      = "jeffkey"
#   tenancy       = "default"
#   subnet_id     = aws_subnet.jeff_Tf_subnet.id

#   tags = {
#     Name = "test_ec2_Instance"
#   }
# }
