resource "aws_ecs_service" "backend_app_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.back_task.arn
  desired_count   = "2"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.internal_sg_task.id]
    subnets         = [var.private_subnets_ids[0], var.private_subnets_ids[1]]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.internal-alb.id
    container_name   = "backend-image"
    container_port   = 5002
  }

  depends_on = [aws_lb_listener.internal_alb_listener]

  tags = {
    Project = "chupito"
  }
}
