variable "region" {
  type        = string
  description = "AWS region to deploy infra into"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC which we are deploying into"
}

variable "service_name" {
  type        = string
  description = "Name of this service"
}

variable "health_check_path" {
  type        = string
  description = "Path to HTTP endpoint for healthcheck. e.g. /health"
}

variable "task_count" {
  type        = number
  description = "Number of tasks to run in ECS service"
}

variable "container_port" {
  type        = number
  description = "Port that service listens to inside container"
}

variable "cpu" {
  type        = number
  description = "CPU for task"
}

variable "memory" {
  type        = number
  description = "Memory for task"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "Allows e.g. 4 tasks while the target is 2 to get the 2 extra healthy before switching to them"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The desired count that must always be running"
}

variable "image" {
  type        = string
  description = "Container image to deploy"
}

variable "task_execution_role_arn" {
  type        = string
  description = "ARN of task execution role. Required by Fargate as we do not manage the underlying ec2 instance."
}

variable "task_role_arn" {
  type        = string
  description = "ARN of task role which is used by the service to perform API calls, etc"
}

variable "alb_arn" {
  type        = string
  description = "ARN of ALB which listener should be attached to."
}

variable "secrets" {
  type        = list(object({ name = string, valueFrom = string }))
  description = "Secrets to be injected into container as environment variables on startup."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets into which to deploy tasks as part of the ECS service"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups assigned to tasks as part of the ECS service"
}

variable "cloudflare_api_token" {
  type        = string
  description = "API token for Cloudflare API"
}

variable "cloudflare_zone" {
  type        = string
  description = "Zone to create in CloudFlare"
}

variable "cloudflare_dns_records" {
  type        = list(object({ type = string, name = string, value = string, ttl = number, proxied = bool }))
  description = "DNS records to create in CloudFlare. You likely want at least one that points to the ALB."
}

variable "health_check_interval" {
  type        = number
  description = "Number of seconds between each health check"
}

variable "health_check_healthy_threshold" {
  type        = number
  description = "Number of healthchecks in a row required to be healthy"
}
