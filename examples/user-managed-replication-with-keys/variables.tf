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

variable "replication" {
  type = map(object({
    kms_key_name = string
  }))
  default     = {}
  description = <<EOD
The replication configuration for the secret.
EOD
}

variable "secret" {
  type        = string
  description = <<EOD
The secret payload to store in Secret Manager.
EOD
}
