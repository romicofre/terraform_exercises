## SET environment variable in your environment: TF_VAR_email_notif_list

variable "email_notif_list" {
  type    = list
  default = ["mail@example.com"] # or change this, to set a default value
}