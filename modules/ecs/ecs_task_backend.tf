resource "aws_ecs_task_definition" "back_task" {
  family                   = "backend-image"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "041581428422.dkr.ecr.us-east-1.amazonaws.com/backend-image:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "backend-image",
    "networkMode": "awsvpc",
    "linuxParameters": {
	    "initProcessEnabled": true
    },
    "enableExecuteCommand": true,
    "environment": [
        {
          "name": "MONGODB_URI",
          "value": "${var.documentdb_endpoint}"
        },
        {
          "name": "MONGO_INITDB_DATABASE",
          "value": "${var.documentdb_name}"
        },
        {
          "name": "MONGO_INITDB_ROOT_USERNAME",
          "value": "${var.documentdb_username}"
        },
        {
          "name": "MONGO_INITDB_ROOT_PASSWORD",
          "value": "${var.documentdb_password}"
        }
    ],
    "portMappings": [
      {
        "containerPort": 5002,
        "hostPort": 5002
      }
    ]
  }
]
DEFINITION
  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn         = aws_iam_role.ecsTaskRole.arn

  tags = {
    Project = "chupito"
  }
}
