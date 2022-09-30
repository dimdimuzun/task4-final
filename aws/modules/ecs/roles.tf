# Get role for ecs task execution
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}
