variable "gcp_project" {
  type        = string
  description = "ID of the GCP project"
}

variable "gcp_credentials" {
  type  = string
  description = "Path of service account json key"
}

variable "dataflow_job_name" {
  type = string
  description = "Job name to can to receive alerts about errors"
}

variable "monitoring_alert_email" {
  type = string
  description = "Email to can to receive alerts about errors"
}