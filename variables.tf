variable "name" {
  type        = string
  description = "The name of your DigitalOcean LoadBalancer."
}

variable "region" {
  type        = string
  description = "The region in which you want to create your DigitalOcean LoadBalancer."
  default     = "ams3"
  nullable = false
}

variable "droplet_tag" {
  type        = string
  description = "The tag assigned to the droplet(s) you want to include in your DigitalOcean LoadBalancer."
  default     = ""
  nullable = false
}

variable "algorithm" {
  type        = string
  description = "The load balancing algorithm used to distribute traffic across the forwarding rules."
  default     = "round_robin"
  nullable = false
}

variable "project" {
  type        = string
  description = "The name of the project to which the LoadBalancer will be assigned."
  default     = null
  nullable = true
}

variable "healthcheck" {
  type = object({
    protocol                 = optional(string)
    port                     = optional(number)
    path                     = optional(string)
    check_interval_seconds   = optional(number)
    response_timeout_seconds = optional(number)
    unhealthy_threshold      = optional(number)
    healthy_threshold        = optional(number)
  })
  description = "The health check settings for the LoadBalancer."
  default     = null
}

variable "sticky_sessions" {
  type = object({
    type               = string
    cookie_name        = optional(string)
    cookie_ttl_seconds = optional(number)
  })
  description = "The sticky session settings for the LoadBalancer."
  default = {
    type               = "none"
    cookie_name        = null
    cookie_ttl_seconds = null
  }
  nullable = false
}


variable "forwarding_rules" {
  type = list(object({
    entry_port       = number
    entry_protocol   = string
    target_port      = number
    target_protocol  = string
    certificate_name = optional(string)
    tls_passthrough  = optional(bool)
  }))
  description = "A list of forwarding rules to configure for your LoadBalancer."
  default = [
    {
      entry_port       = 80
      entry_protocol   = "http"
      target_port      = 80
      target_protocol  = "http"
      certificate_name = null
    },
    {
      entry_port       = 443
      entry_protocol   = "https"
      target_port      = 443
      target_protocol  = "https"
      certificate_name = null
      tls_passthrough  = null
    }
  ]
  nullable = false
}

variable "proxy_protocol" {
  type        = bool
  description = "Whether to enable the PROXY Protocol for your LoadBalancer."
  default     = false
  nullable = false
}
