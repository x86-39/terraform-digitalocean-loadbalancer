resource "digitalocean_loadbalancer" "lb" {
  name                  = var.name
  region                = var.region
  droplet_tag           = var.droplet_tag
  algorithm             = var.algorithm
  enable_proxy_protocol = var.proxy_protocol

  dynamic "healthcheck" {
    for_each = var.healthcheck == null ? toset([]) : toset([1])

    content {
      protocol                 = var.healthcheck.protocol
      port                     = var.healthcheck.port
      path                     = var.healthcheck.path
      check_interval_seconds   = var.healthcheck.check_interval_seconds
      response_timeout_seconds = var.healthcheck.response_timeout_seconds
      unhealthy_threshold      = var.healthcheck.unhealthy_threshold
      healthy_threshold        = var.healthcheck.healthy_threshold
    }
  }

  sticky_sessions {
    type               = var.sticky_sessions.type
    cookie_name        = var.sticky_sessions.cookie_name
    cookie_ttl_seconds = var.sticky_sessions.cookie_ttl_seconds
  }

  dynamic "forwarding_rule" {
    for_each = var.forwarding_rules

    content {
      entry_port       = forwarding_rule.value.entry_port
      entry_protocol   = forwarding_rule.value.entry_protocol
      target_port      = forwarding_rule.value.target_port
      target_protocol  = forwarding_rule.value.target_protocol
      certificate_name = forwarding_rule.value.certificate_name
      tls_passthrough  = forwarding_rule.value.tls_passthrough
    }
  }
}

data "digitalocean_project" "existing_project" {
  name = var.project
}

resource "digitalocean_project_resources" "lb_resources" {
  project = data.digitalocean_project.existing_project.id
  resources = [
    digitalocean_loadbalancer.lb.urn
  ]
}