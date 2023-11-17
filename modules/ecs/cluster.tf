
resource "aws_ecs_cluster" "main" {
  name = "example-cluster"
}

resource "aws_ecs_service" "hello_world" {
  name            = "chupito-front-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = "2"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.hello_world_task.id]
    subnets         = [var.private_subnets_ids[0], var.private_subnets_ids[1]] #private subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hello_world.id
    container_name   = "chupito-front"
    #container_port   = 3000
    container_port   = 80
  }

  depends_on = [aws_lb_listener.hello_world]
}

