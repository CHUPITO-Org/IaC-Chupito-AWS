resource "aws_ecs_task_definition" "hello_world" {
  family                   = "chupito-front"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048


  #"image": "${aws_ecr_repository.ecr.repository_url}",
  #"name": "container-name", "hello-world-react",
  #"image": "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest",
  container_definitions = <<DEFINITION
[
  {
    "image": "041581428422.dkr.ecr.us-east-1.amazonaws.com/chupito-front:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "chupito-front",
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
}

resource "aws_security_group" "hello_world_task" {
  name   = "task-security-group"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    #from_port       = 3000
    #to_port         = 3000
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
}
