data "aws_iam_role" "task_execution_role" {
  name = var.task_execution_role_arn
}

data "aws_iam_role" "task_role" {
  name = var.task_role_arn
}

data "aws_lb" "this" {
  name = var.alb_arn
}
