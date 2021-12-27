# Fargate deployment

This Terraform module deploys a container into ECS Fargate and attaches a listener to an ALB with a target group which ECS registers targets with.

DNS records can be created in Cloudflare and logs are sent to CloudWatch.

It is assumed that TLS will be handled by Cloudflare which is much simpler than managing certificates and DNS records in AWS. (having to create certs in ACM, verify identity, etc)

## Cloudflare

You must provide an API token for Cloudflare. This allows you to reduce permission down to only the zone that we are creating.

You must already have a zone created in Cloudflare. This is because the responsibility of creating the zone should not belong to this module; for example some other Terraform code somewhere else may also be adding DNS records which you would not want to be deleted by this module.