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

variable "topics" {
  type        = list(string)
  description = <<EOD
An optional list of Cloud Pub/Sub topics that will receive control-plane events for the secret.
EOD
}
