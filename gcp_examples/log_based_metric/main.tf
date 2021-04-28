/*
Set environment variables
export GOOGLE_PROJECT=my-project
*/

resource "google_logging_metric" "logging_metric" {
  name   = "dataflow-error/metric"
  filter = "resource.type=dataflow_step AND severity>=ERROR"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
