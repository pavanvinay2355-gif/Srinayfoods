resource "aws_db_instance" "godavari_db" {
  identifier             = "${var.project_name}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  storage_encrypted      = false
  backup_retention_period = 1

  tags = { Name = "${var.project_name}-db" }
}
