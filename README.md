# Fargate deployment

This Terraform module deploys a container into ECS Fargate and attaches a listener to an ALB with a target group which ECS registers targets with.

DNS records can be created in Cloudflare and logs are sent to CloudWatch.

It is assumed that TLS will be handled by Cloudflare which is much simpler than managing certificates and DNS records in AWS. (having to create certs in ACM, verify identity, etc)

## Cloudflare credentials

You must provide an API token for Cloudflare. This allows you to reduce permission down to only the zone that we are creating.

There is a slight chicken and egg situation as the Terraform is creating the zone, so you will first have to use a more permissive API token and then downgrade to one that is limited to only the zone we have created.
