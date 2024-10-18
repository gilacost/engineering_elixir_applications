variable "grafana_url" {
  description = "The endpoint URL for Grafana"
  type        = string
}

variable "grafana_auth" {
  description = "The authentication method or token for Grafana"
  type        = string
  default     = "anonymous"
}

variable "prometheus_url" {
  description = "The URL for the Prometheus data source"
  type        = string
}

variable "loki_url" {
  description = "The URL for the Loki data source"
  type        = string
}

variable "alert_contact_email" {
  description = "The email address to send alert notifications"
  type        = string
}
