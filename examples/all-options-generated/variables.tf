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

variable "length" {
  type        = number
  description = <<EOD
The length of the random string to generate for secret value.
EOD
}

variable "has_upper_chars" {
  type        = bool
  description = <<EOD
Include uppercase alphabet characters in the generated secret.
EOD
}

variable "min_upper_chars" {
  type        = number
  description = <<EOD
The minimum number of uppercase characters to include in the generated secret.
EOD
}

variable "has_lower_chars" {
  type        = bool
  description = <<EOD
Include lowercase alphabet characters in the generated secret.
EOD
}

variable "min_lower_chars" {
  type        = number
  description = <<EOD
The minimum number of lowercase characters to include in the generated secret.
EOD
}

variable "has_numeric_chars" {
  type        = bool
  description = <<EOD
Include numeric characters in the generated secret.
EOD
}

variable "min_numeric_chars" {
  type        = number
  description = <<EOD
The minimum number of numeric characters to include in the generated secret.
EOD
}

variable "has_special_chars" {
  type        = bool
  description = <<EOD
Include special characters in the generated secret.
EOD
}

variable "min_special_chars" {
  type        = number
  description = <<EOD
The minimum number of special characters to include in the generated secret.
EOD
}

variable "special_char_set" {
  type        = string
  description = <<EOD
Override the 'special' characters used by Terraform's random_string provider to
the set provided.
EOD
}
