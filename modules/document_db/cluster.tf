resource "aws_docdb_cluster" "docdb" {
  #CONFIGURATION
  cluster_identifier = "my-docdb-cluster"
  engine             = "docdb"

  #AUTHENTICATION
  master_username = var.documentdb_username
  master_password = var.documentdb_password

  #NETWORK SETTINGS
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.vpc_documentdb_sg.id]
  availability_zones     = ["us-east-1a", "us-east-1b"]

  #CLUSTER OPTIONS
  port = 27017

  #ENCRYPTION-AT-REST
  storage_encrypted = true

  #BACKUP
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"

  #TAGS
  tags = {
    Project = "chupito"
  }

  #DELETION PROTECTION
  skip_final_snapshot = true
}

resource "aws_security_group" "vpc_documentdb_sg" {
  name        = "security-group-documendb"
  vpc_id      = var.vpc_id
  description = "Allow 27017"

  ingress {
    protocol    = "tcp"
    from_port   = 27017
    to_port     = 27017
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "chupito"
  }
}
