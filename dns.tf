data "cloudflare_zone" "this" {
  name = var.cloudflare_zone
}

resource "cloudflare_record" "this" {
  count   = length(var.cloudflare_dns_records)
  zone_id = data.cloudflare_zone.this.id
  type    = var.cloudflare_dns_records[count.index].type
  name    = var.cloudflare_dns_records[count.index].name
  value   = var.cloudflare_dns_records[count.index].value
  ttl     = var.cloudflare_dns_records[count.index].ttl
  proxied = var.cloudflare_dns_records[count.index].proxied
}
