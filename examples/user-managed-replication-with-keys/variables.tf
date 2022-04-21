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

variable "replication_keys" {
  type        = map(string)
  description = <<EOD
An optional map of customer managed keys per location. This needs to match the
locations specified in `replication_locations`.

E.g. replication_keys = { "us-east1": "my-key-name", "us-west1": "another-key-name" }
EOD
}
