resource "aws_ecs_cluster" "main" {
  name = "cluster-app"

  tags = {
    Project = "chupito"
  }
}