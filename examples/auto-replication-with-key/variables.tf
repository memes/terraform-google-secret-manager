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

variable "auto_replication_kms_key_name" {
  type        = string
  description = <<EOD
The Cloud KMS key name to use with Google managed replication.
EOD
}

variable "secret" {
  type        = string
  description = <<EOD
The secret payload to store in Secret Manager.
EOD
}
