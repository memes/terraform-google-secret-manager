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

variable "replication_locations" {
  type        = list(string)
  default     = []
  description = <<EOD
A list of replication locations for the secret.
EOD
}

variable "secret" {
  type        = string
  description = <<EOD
The secret payload to store in Secret Manager.
EOD
}
