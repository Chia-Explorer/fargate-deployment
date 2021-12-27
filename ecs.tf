resource "aws_ecs_cluster" "this" {
  name = "${var.service_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.service_name}-task-definition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  network_mode = "awsvpc"

  execution_role_arn = var.task_execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([{
    name        = local.container_name
    image       = var.image
    essential   = true
    environment = []
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
    }],
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-region        = var.region
        awslogs-stream-prefix = "ecs"
        awslogs-group         = "/ecs/${var.service_name}"
      }
    }
    secrets = var.secrets
  }])
}

resource "aws_ecs_service" "this" {
  name             = "${var.service_name}-service"
  cluster          = aws_ecs_cluster.this.id
  task_definition  = aws_ecs_task_definition.this.arn
  desired_count    = var.task_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }
}
