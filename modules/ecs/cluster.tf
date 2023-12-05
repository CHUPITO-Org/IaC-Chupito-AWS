resource "aws_ecs_cluster" "main" {
  name = "cluster-app"

  tags = {
    Project = "chupito"
  }
}

resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.front_task.arn
  desired_count   = "2"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.sg_task.id]
    subnets         = [var.private_subnets_ids[0], var.private_subnets_ids[1]]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb.id
    container_name   = "frontend-image"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.alb_listener]

  tags = {
    Project = "chupito"
  }
}


