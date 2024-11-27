terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.13.1"
    }
  }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

resource "grafana_data_source" "prometheus" {
  uid  = "P1809F7CD0C75ACF3"
  name = "Prometheus"
  type = "prometheus"
  url  = var.prometheus_url
}

resource "grafana_data_source" "loki" {
  name = "Loki"
  type = "loki"
  url  = var.loki_url
}

resource "grafana_folder" "alerts" {
  title = "alerts"
}

resource "grafana_rule_group" "rule_group_0000" {
  org_id           = 1
  name             = "main"
  folder_uid       = grafana_folder.alerts.uid
  interval_seconds = 60

  rule {
    name      = "High CPU Usage"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"P1809F7CD0C75ACF3\"},\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"avg (cpu_util)\",\"format\":\"table\",\"hide\":false,\"instant\":true,\"interval\":\"\",\"intervalMs\":1000,\"legendFormat\":\"\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"B\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"hide\":false,\"intervalMs\":1000,\"maxDataPoints\":43200,\"reducer\":\"last\",\"refId\":\"B\",\"settings\":{\"mode\":\"dropNN\"},\"type\":\"reduce\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[40],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"B\",\"hide\":false,\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
  }
}

resource "grafana_contact_point" "main_contact_point" {
  name = "Main Contact Point"

  email {
    addresses    = [var.alert_contact_email]
    single_email = false
  }
}

resource "grafana_notification_policy" "main_notification_policy" {
  group_by      = ["grafana_folder", "alertname"]
  contact_point = grafana_contact_point.main_contact_point.name

  group_wait      = "45s"
  group_interval  = "6m"
  repeat_interval = "3h"

  policy {
    contact_point = grafana_contact_point.main_contact_point.name
    continue      = true
  }
}
