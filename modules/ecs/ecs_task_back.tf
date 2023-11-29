resource "aws_ecs_task_definition" "back_task" {
  family                   = "backend-image"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  #"image": "041581428422.dkr.ecr.us-east-1.amazonaws.com/backend-image:latest",
  container_definitions = <<DEFINITION
[
  {
    "image": "041581428422.dkr.ecr.us-east-1.amazonaws.com/backend-image:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "backend-image",
    "networkMode": "awsvpc",
    "environment": [
        {
          "name": "MONGODB_URI",
          "value": "${var.documentdb_endpoint}"
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
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]
DEFINITION
  #Add when we use an image from ECR
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn

  tags = {
    Project = "chupito"
  }
}

resource "aws_security_group" "internal_sg_task" {
  name   = "internal-task-security-group"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80   #frontend port
    to_port         = 8080 #backend port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "chupito"
  }
}
