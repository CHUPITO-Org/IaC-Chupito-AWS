resource "aws_ecs_task_definition" "front_task" {
  family                   = "frontend-image"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "041581428422.dkr.ecr.us-east-1.amazonaws.com/frontend-image:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "frontend-image",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
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

resource "aws_security_group" "sg_task" {
  name   = "task-security-group"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
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
