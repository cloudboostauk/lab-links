# Create database
resource "aws_db_instance" "default" {
  count             = 2
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.39"  
  instance_class    = "db.t3.micro" 
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0" 
  db_subnet_group_name = aws_db_subnet_group.mydb_subnet_group.name
  skip_final_snapshot  = true
}