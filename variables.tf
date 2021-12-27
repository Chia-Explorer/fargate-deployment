variable "region" {
  type        = string
  description = "AWS region to deploy infra into"
}

variable "service_name" {
  type        = string
  description = "Name of this service"
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
  type        = list(object({ type = string, name = string, value = string, ttl = number }))
  description = "DNS records to create in CloudFlare. You likely want at least one that points to the ALB."
}
