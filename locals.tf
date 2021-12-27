data "aws_caller_identity" "current" {}

locals {
  account_id     = data.aws_caller_identity.current.account_id
  container_name = "${var.service_name}-container"
  log_group_name = "/ecs/${var.service_name}"
}
