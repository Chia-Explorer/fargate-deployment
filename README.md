# Fargate deployment

This Terraform module deploys a container into ECS Fargate and attaches a listener to an ALB with a target group which ECS registers targets with.

DNS records can be created in Cloudflare and logs are sent to CloudWatch.

It is assumed that TLS will be handled by Cloudflare which is much simpler than managing certificates and DNS records in AWS. (having to create certs in ACM, verify identity, etc)

## Cloudflare

You must provide an API token for Cloudflare. This allows you to reduce permission down to only the zone that we are creating.

You must already have a zone created in Cloudflare. This is because the responsibility of creating the zone should not belong to this module; for example some other Terraform code somewhere else may also be adding DNS records which you would not want to be deleted by this module.

## Example usage

```
module "deployment" {
  source = "git::https://github.com/Chia-Explorer/fargate-deployment?ref=1.0.0"

  region = var.region
  vpc_id = data.terraform_remote_state.infra.outputs.vpc_id

  cloudflare_api_token   = var.cloudflare_api_token
  cloudflare_zone        = var.cloudflare_zone
  cloudflare_dns_records = [{
      type = "CNAME"
      name = "dev-api"
      value = data.terraform_remote_state.infra.outputs.public_alb_dns_name
      ttl = 3600
  }]

  service_name = var.service_name

  image      = var.image
  task_count = var.task_count

  cpu                                = var.cpu
  memory                             = var.memory
  container_port                     = var.container_port
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  health_check_path                  = var.health_check_path

  task_execution_role_arn = data.terraform_remote_state.infra.outputs.task_execution_role_arn
  task_role_arn           = data.terraform_remote_state.infra.outputs.task_role_arn
  alb_arn                 = data.terraform_remote_state.infra.outputs.public_alb_arn
  secrets                 = data.terraform_remote_state.infra.outputs.secrets

  subnet_ids         = data.terraform_remote_state.infra.outputs.subnet_ids
  security_group_ids = [data.terraform_remote_state.infra.outputs.internal_load_balancer_security_group_id]
}
```