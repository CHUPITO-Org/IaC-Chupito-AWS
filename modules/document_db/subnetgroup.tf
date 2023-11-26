resource "aws_db_subnet_group" "db_subnet_group" {
  name = "main"

  subnet_ids = [
    var.db_subnets_ids[0],
    var.db_subnets_ids[1]
    #    aws_subnet.eu-west-3a.id,
    #aws_subnet.eu-west-3b.id
  ]

  tags = {
    Name    = "My DB subnet group"
    Project = "chupito"
  }
}
