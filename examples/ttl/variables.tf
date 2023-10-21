variable "project_id" {
  type        = string
  description = <<EOD
The GCP project identifier where the secret will be created.
EOD
}

variable "id" {
  type        = string
  description = <<EOD
The secret identifier to create; this value must be unique within the project.
EOD
}

variable "secret" {
  type        = string
  description = <<EOD
The secret payload to store in Secret Manager.
EOD
}

variable "ttl_secs" {
  type        = number
  default     = null
  description = <<EOD
The time-to-live value expressed as a number of seconds; the secret will be automatically deleted after this
duration.
EOD
}
