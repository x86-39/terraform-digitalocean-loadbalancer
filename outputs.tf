output "id" {
  value = digitalocean_loadbalancer.lb.id
}

output "name" {
  value = digitalocean_loadbalancer.lb.name
}

output "ipv4_address" {
  value = digitalocean_loadbalancer.lb.ip
}

output "status" {
  value = digitalocean_loadbalancer.lb.status
}

output "droplet_ids" {
  value = digitalocean_loadbalancer.lb.droplet_ids
}

output "algorithm" {
  value = digitalocean_loadbalancer.lb.algorithm
}

output "sticky_sessions" {
  value = digitalocean_loadbalancer.lb.sticky_sessions
}

output "healthcheck" {
  value = digitalocean_loadbalancer.lb.healthcheck
}

output "redirect_http_to_https" {
  value = digitalocean_loadbalancer.lb.redirect_http_to_https
}
