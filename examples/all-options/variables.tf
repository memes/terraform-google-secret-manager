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
An optional list of replication locations for the secret.
EOD
}

variable "replication_keys" {
  type        = map(string)
  description = <<EOD
A map of customer managed keys per location. This needs to match the
locations specified in `replication_locations`.

E.g. replication_keys = { "us-east1": "my-key-name", "us-west1": "another-key-name" }
EOD
}

variable "secret" {
  type        = string
  description = <<EOD
The secret payload to store in Secret Manager; if blank or null a versioned secret
value will NOT be created and must be populated outside of this module. Binary
values should be base64 encoded before use.
EOD
}

variable "accessors" {
  type        = list(string)
  description = <<EOD
An optional list of IAM account identifiers that will be granted accessor (read-only)
permission to the secret.
EOD
}

variable "labels" {
  type        = map(string)
  description = <<EOD
An optional map of label key:value pairs to assign to the secret resources.
EOD
}
