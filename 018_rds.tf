resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-rds-subnets"
  subnet_ids  = [aws_subnet.jeff_DB_subnet5.id, aws_subnet.jeff_DB_subnet6.id]
  description = "RDS subnet groups"
  tags = {
    Name = "${var.project_name}-${var.environment}-rds-subnets"
  }
}

resource "aws_db_instance" "mysql_instance" {
  identifier        = "${var.project_name}-${var.environment}-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "sample"
  username = "admin"
  password = "password123"  # Change this in production

  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_public_sg.id]

  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true
  parameter_group_name   = "default.mysql8.0"


  tags = {
    Name = "${var.project_name}-${var.environment}-mysql"
  }
}


