module "grafana_setup" {
  source              = "../../modules/instrumentation/grafana"
  grafana_url         = "http://52.210.128.135:3000"
  grafana_auth        = "anonymous"
  prometheus_url      = "http://prometheus:9090"
  loki_url            = "http://loki:3100"
  alert_contact_email = "YOUR_EMAIL_ADDRESS"
}
