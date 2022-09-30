# Cluster ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "cluster-${var.environment}-${var.app_name}"
}

# Service ECS
resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    #subnets          = var.private_subnets_id
    subnets          = var.public_subnets_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.app_name}-${var.environment}-app"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end]
}

