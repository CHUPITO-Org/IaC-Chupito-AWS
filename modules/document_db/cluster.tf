resource "aws_docdb_cluster" "docdb" {
  #CONFIGURATION
  cluster_identifier = "my-docdb-cluster"
  engine             = "docdb" # The name of the database engine to be used for this DB cluster. Defaults to docdb. Valid Values: docdb

  #AUTHENTICATION
  master_username = "root"
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
  backup_retention_period = 5             #The days to retain backups for. Default 1
  preferred_backup_window = "07:00-09:00" #The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC Default: A 30-minute window selected at random from an 8-hour block of time per regionE.g., 04:00-09:00
  apply_immediately       = false

  #TAGS
  tags = {
    Project = "chupito"
  }

  #DELETION PROTECTION
  # final_snapshot_identifier - (Optional) The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made.
  skip_final_snapshot = true #Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier. Default is false.

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
