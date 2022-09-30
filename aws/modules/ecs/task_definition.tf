
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}-${var.environment}-task"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.task_definition_template.rendered
}

data "template_file" "task_definition_template" {
  template = templatefile("task_definition.json.tpl", {

    ecr_url        = var.ecr_url
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    env            = var.environment
    app_name       = var.app_name
    image_tag      = var.image_tag
  })
}
