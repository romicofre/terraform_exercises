terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = var.gcp_credentials

  project = var.gcp_project
  region  = "us-central1"
  zone    = "us-central1-c"
}



/*

  Create dataflow job alert

*/


# Create logging metric of specific dataflow in filter
resource "google_logging_metric" "dataflow_logging_metric" {
  name   = "dataflow-error/metric"
  filter = format("resource.type=dataflow_step AND severity>=ERROR AND resource.labels.job_name=%s", var.dataflow_job_name)

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}


# Create a notification channel, copy to add more emails
resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = "Error Dataflow Notification Channel"
  type         = "email"
  labels = {
    email_address = var.monitoring_alert_email
  }
}


# Create a policy alert using log-based metric "dataflow-error/metric"
resource "google_monitoring_alert_policy" "dataflow_alert_policy" {
  depends_on = [google_logging_metric.dataflow_logging_metric, google_monitoring_notification_channel.notification_channel]
  display_name = "Dataflow Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = format("Log error in %s dataflow job", var.dataflow_job_name)
    condition_threshold {
      filter     = format("metric.type=\"logging.googleapis.com/user/%s\" AND resource.type=\"dataflow_job\"", google_logging_metric.dataflow_logging_metric.name)
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.notification_channel.id]
  user_labels = {
    env = "dev"
  }
}
