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

variable "accessors" {
  type        = list(string)
  description = <<EOD
An optional list of IAM account identifiers that will be granted accessor (read-only)
permission to the secret.
EOD
}
